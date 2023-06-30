from django.shortcuts import render,redirect
from .models import *
from modulos.Vehiculo.models import Vehiculo
from django.contrib import messages
from django.db.models import Q

def registrar_mantenimiento(request):
    vehiculos = Vehiculo.objects.all()
    
    if request.method == 'POST':
        # Obtén los datos del formulario de mantenimiento
        vehiculo_id = request.POST['vehiculo_id']
        comentario = request.POST['comentario']
        fecha = request.POST['fecha']
        costo = request.POST['costo']
        
        # Crea un nuevo objeto de mantenimiento
        mantenimiento = Mantenimiento(
            vehiculo_id=vehiculo_id,
            mantenimiento_comentario=comentario,
            mantenimiento_fecha=fecha,
            mantenimiento_costo=costo
        )
        
        try:
            # Guarda el objeto en la base de datos
            mantenimiento.save()
            
            messages.success(request, 'El mantenimiento se registró correctamente.')
            
            return redirect('listaMantenimiento')  # Redirige a la página de éxito o a otra vista
        
        except Exception as e:
            messages.error(request, 'Ocurrió un error al guardar el mantenimiento: {}'.format(str(e)))
    
    return render(request, 'Mantenimiento/registrarMantenimiento.html', {'vehiculos': vehiculos})

def listaMantenimiento(request):
    vehiculos = Vehiculo.objects.all()
    mantenimientos = Mantenimiento.objects.all()
    return render(request,'Mantenimiento/listaMantenimiento.html',{'vehiculos':vehiculos, 'mantenimientos':mantenimientos})


def modificar_mantenimiento(request, mantenimiento_id,modificando):
    vehiculos = Vehiculo.objects.all()
    mantenimiento = Mantenimiento.objects.get(mantenimiento_id=int(mantenimiento_id))
    if(modificando==0):
        return render(request, 'Mantenimiento/modificarMantenimiento.html', {'vehiculos': vehiculos, 'mantenimiento': mantenimiento})
    else:
        if request.method == 'POST':
            # Obtén los datos del formulario de mantenimiento
            vehiculo_id = request.POST['vehiculo_id']
            comentario = request.POST['comentario']
            fecha = request.POST['fecha']
            costo = request.POST['costo']
            try:
                # Actualiza los datos del objeto de mantenimiento existente
                mantenimiento.vehiculo_id = vehiculo_id
                mantenimiento.mantenimiento_comentario = comentario
                mantenimiento.mantenimiento_fecha = fecha
                mantenimiento.mantenimiento_costo = costo
                mantenimiento.save()
                messages.success(request, 'El mantenimiento se modificó correctamente.')
            except Exception as e:
                messages.error(request, 'Ocurrió un error al modificar el mantenimiento: {}'.format(str(e)))
        return redirect('listaMantenimiento')


def listar_mantenimiento(request):
    mantenimientos = []
    busqueda = False
    vehiculos = []

    if request.method == "POST":
        search_query = request.POST['txt_buscar']

        if search_query != "":
            mantenimientos = Mantenimiento.objects.filter(
                Q(mantenimiento_comentario__icontains=search_query) |
                Q(mantenimiento_fecha__icontains=search_query) |
                Q(mantenimiento_costo__icontains=search_query) |
                Q(vehiculo__vehiculo_placa__icontains=search_query) |
                Q(vehiculo__vehiculo_marca__icontains=search_query)
            )
        else:
            messages.success(request, "No hay resultados")

        busqueda = True
    else:
        mantenimientos = Mantenimiento.objects.all()
        vehiculos = Vehiculo.objects.all()

    return render(request, 'Mantenimiento/listaMantenimiento.html', {'mantenimientos': mantenimientos, 'vehiculos': vehiculos, 'busqueda': busqueda})
