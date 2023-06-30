from django.shortcuts import render,redirect,HttpResponse
from modulos.Instructor.models import Instructor
from modulos.core.models import Empleado
from .models import *
from django.contrib import messages


def llenar_encuesta(request):

    instructores = Instructor.objects.all()

    context = {
        'instructores': instructores
    
    }
    
    if request.method == 'POST':

        instructor_id = request.POST.get('instructor', None)
        print(instructor_id)
        pregunta1 = int(request.POST.get('pregunta1', 1))
        pregunta2 = int(request.POST.get('pregunta2', 1))
        pregunta3 = int(request.POST.get('pregunta3', 1))
        pregunta4 = int(request.POST.get('pregunta4', 1))
        pregunta5 = int(request.POST.get('pregunta5', 10))
        pregunta6 = int(request.POST.get('pregunta6', 0))
        pregunta7 = int(request.POST.get('pregunta7', 0))
        encuesta_comentario = request.POST.get('encuesta_comentario', '')
        instructor = Instructor.objects.get(instructor_id = int(instructor_id))

        encuesta = Encuesta(
            instructor = instructor,
            pregunta1=pregunta1,
            pregunta2=pregunta2,
            pregunta3=pregunta3,
            pregunta4=pregunta4,
            pregunta5=pregunta5,
            pregunta6=pregunta6,
            pregunta7=pregunta7,
            encuesta_comentario=encuesta_comentario
        )
        encuesta.save()  # Guardar la encuesta en la base de datos
        return redirect(request.path)

    else:
        return render(request,'encuesta/encuesta.html', context)