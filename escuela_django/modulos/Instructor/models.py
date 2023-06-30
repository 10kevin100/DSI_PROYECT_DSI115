from django.db import models
from modulos.core.models import Rol, Usuario, Empleado


class Instructor(models.Model):
    instructor_id = models.SmallAutoField(primary_key=True)
    empleado = models.ForeignKey(Empleado, models.DO_NOTHING)

    def __str__(self):
        return str(self.instructor_id)
    
    class Meta:
        managed = False
        db_table = 'instructor'

# Create your models here.
