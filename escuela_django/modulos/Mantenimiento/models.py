from django.db import models
from modulos.Vehiculo.models import Vehiculo

class Mantenimiento(models.Model):
    mantenimiento_id = models.AutoField(primary_key=True)
    vehiculo = models.ForeignKey(Vehiculo, models.DO_NOTHING, blank=True, null=True)
    mantenimiento_comentario = models.CharField(max_length=500)
    mantenimiento_fecha = models.DateField()
    mantenimiento_costo = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'Mantenimiento'