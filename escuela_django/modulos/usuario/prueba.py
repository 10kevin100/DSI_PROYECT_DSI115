import random
nombre = "Caleb"
apellido = "Escoto"
id=random.randint(0,999)
usuario=nombre[0].lower() + apellido.lower() + str(id).zfill(3)
print(usuario) 