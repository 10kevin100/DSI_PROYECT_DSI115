from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required 
from .models import *
from modulos.Vehiculo.models import *
from modulos.Mantenimiento.models import Mantenimiento


def lista_empleados(request):
    empleados = Empleado.objects.all()  # Recupera todos los registros de la tabla Empleado
    instructores = Instructor.objects.all()
    
    return render(request, 'Instructor/Instructor.html', {'empleados': empleados, 'instructores':instructores})

@login_required
def asignarInstructor(request, empleado_id):
    if Instructor.objects.filter(empleado_id=empleado_id).exists():
        messages.warning(request, 'Ya existe el instructor')
        
    else:
        empleado = Empleado.objects.get(empleado_id=int(empleado_id))
        usuario = Usuario.objects.get(usuario_id = empleado.usuario.usuario_id)
        usuario.rol=Rol.objects.get(rol_id = 2)
        usuario.save()
        instructor = Instructor.objects.create(empleado=empleado)
        messages.success(request, 'Instructor asignado correctamente.')
    return redirect('/modules/Instructor')

@login_required
def removerInstructor(request, empleado_id):
    try:
        empleado = Empleado.objects.get(empleado_id=int(empleado_id))
        instructor = Instructor.objects.get(empleado_id=empleado_id)
        usuario = Usuario.objects.get(usuario_id = empleado.usuario.usuario_id)
        usuario.rol=Rol.objects.get(rol_id = 3)
        usuario.save()
        for vehiculo in Vehiculo.objects.all():
            if(instructor == vehiculo.instructor):
                for mantenimiento in Mantenimiento.objects.all():
                    if mantenimiento.vehiculo == vehiculo:
                        mantenimiento.delete()
                vehiculo.delete()
        instructor.delete()
        messages.success(request, 'Instructor removido correctamente.')
    except Instructor.DoesNotExist:
        messages.error(request, 'El instructor no existe.')
    return redirect('/modules/Instructor')

            
