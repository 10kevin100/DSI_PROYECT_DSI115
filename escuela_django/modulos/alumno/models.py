from django.db import models

# Create your models here.

class Alumno(models.Model):
    alumno_id = models.AutoField(primary_key=True)
    alumno_nombre = models.CharField(max_length=50)
    alumno_apellido = models.CharField(max_length=75)
    alumno_telefono = models.CharField(max_length=15, blank=True, null=True)
    alumno_encargado = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'alumno'


class Licencia(models.Model):
    licencia_id = models.SmallAutoField(db_column='licencia_Id', primary_key=True)  # Field name made lowercase.
    licencia_tipo = models.CharField(max_length=7)

    class Meta:
        managed = False
        db_table = 'licencia'

class AlumnoLicencia(models.Model):
    licencia = models.OneToOneField('Licencia', models.DO_NOTHING, db_column='licencia_Id', primary_key=True)  # Field name made lowercase. The composite primary key (licencia_Id, alumno_id) found, that is not supported. The first column is selected.
    alumno = models.ForeignKey('Alumno', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'alumno_licencia'
        unique_together = (('licencia', 'alumno'),)

class Documentoidentidad(models.Model):
    alumno = models.ForeignKey(Alumno, models.DO_NOTHING)
    documento_id = models.SmallAutoField(primary_key=True)
    documento_tipo = models.CharField(max_length=21)
    documento_num = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'documentoIdentidad'