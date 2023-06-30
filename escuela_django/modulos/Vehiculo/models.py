from django.db import models
from modulos.Instructor.models import Instructor

class Vehiculo(models.Model):
    vehiculo_id = models.AutoField(primary_key=True)
    instructor = models.ForeignKey(Instructor, models.DO_NOTHING, blank=True, null=True)
    vehiculo_placa = models.CharField(unique=True, max_length=25)
    vehiculo_marca = models.CharField(max_length=25)
    vehiculo_tipo = models.CharField(max_length=11)
    vehiculo_transmision = models.CharField(max_length=10)

    class Meta:
        managed = False
        db_table = 'Vehiculo'


