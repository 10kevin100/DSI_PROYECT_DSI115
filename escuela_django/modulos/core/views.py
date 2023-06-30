#Importando el metodo render
from django.shortcuts import render, redirect
#Importando metodo login_required para requerir inicio de sesion en ciertos sites
from django.contrib.auth.decorators import login_required
#Importando libreria para logout
from django.contrib.auth import logout
#Importando modelo User
from django.contrib.auth.models import User
from django.http import HttpResponse




# Favor, agregar aqui los sites como funciones, usar render para cargar
# Para los sites que requieren inciio de sesion colocar @login_required

def home(request):
    return render(request,'home.html')

@login_required
def modules(request):
    return render(request,'modules.html')

@login_required
def sign_out(request):
    logout(request)
    return redirect('home')

def mision(request):
    return render(request,'mision.html')