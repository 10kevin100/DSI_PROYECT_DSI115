from django.db import models
from modulos.Instructor.models import Instructor

class Encuesta(models.Model):
    encuesta_id = models.AutoField(primary_key=True)
    instructor = models.ForeignKey(Instructor, models.DO_NOTHING, blank=True, null=False)
    encuesta_fecha = models.DateField(auto_now_add=True)
    pregunta1 = models.IntegerField()
    pregunta2 = models.IntegerField()
    pregunta3 = models.IntegerField()
    pregunta4 = models.IntegerField()
    pregunta5 = models.IntegerField()
    pregunta6 = models.IntegerField()
    pregunta7 = models.IntegerField()
    encuesta_comentario = models.CharField(max_length=255)
    
    class Meta:
        managed = False
        db_table = 'encuesta'
