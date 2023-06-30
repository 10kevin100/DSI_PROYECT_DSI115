from django.db import models


class Empleado(models.Model):
    usuario = models.ForeignKey('Usuario', models.DO_NOTHING)
    empleado_id = models.AutoField(primary_key=True)
    empleado_nombre = models.CharField(max_length=25)
    empleado_apellido = models.CharField(max_length=50)
    empleado_telefono = models.CharField(max_length=20)
    empleado_fechainicio = models.DateField(db_column='empleado_fechaInicio')  # Field name made lowercase.
    empleado_fechafin = models.DateField(db_column='empleado_fechaFin', blank=True, null=True)  # Field name made lowercase.

    def __str__(self):
        return str(self.empleado_nombre)

    class Meta:
        managed = False
        db_table = 'empleado'
    



class Modulo(models.Model):
    modulo_id = models.AutoField(primary_key=True)
    modulo_nombre = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'modulo'


class ModuloOperacion(models.Model):
    operacion = models.OneToOneField('Operacion', models.DO_NOTHING, primary_key=True)  # The composite primary key (operacion_id, modulo_id) found, that is not supported. The first column is selected.
    modulo = models.ForeignKey(Modulo, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'modulo_operacion'
        unique_together = (('operacion', 'modulo'),)




class Operacion(models.Model):
    operacion_id = models.AutoField(primary_key=True)
    operacion_nombre = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'operacion'




class Rol(models.Model):
    rol_id = models.AutoField(primary_key=True)
    rol_nombre = models.CharField(max_length=50)

    def __str__(self):
        return self.rol_nombre

    class Meta:
        managed = False
        db_table = 'rol'


class RolModulo(models.Model):
    modulo = models.OneToOneField(Modulo, models.DO_NOTHING, primary_key=True)  # The composite primary key (modulo_id, rol_id) found, that is not supported. The first column is selected.
    rol = models.ForeignKey(Rol, models.DO_NOTHING)

   


    class Meta:
        managed = False
        db_table = 'rol_modulo'
        unique_together = (('modulo', 'rol'),)


class Usuario(models.Model):
    usuario_id = models.AutoField(primary_key=True)
    rol = models.ForeignKey('Rol', models.DO_NOTHING, blank=True, null=True)
    usuario_nombre = models.CharField(max_length=50)
    usuario_fechacreacion = models.DateField(db_column='usuario_fechaCreacion')  # Field name made lowercase.
    usuario_estado = models.PositiveIntegerField(blank=True, null=True)
    correo = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'usuario'




