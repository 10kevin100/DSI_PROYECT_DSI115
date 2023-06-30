# Generated by Django 4.2.1 on 2023-06-02 23:30

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Mantenimiento',
            fields=[
                ('mantenimiento_id', models.AutoField(primary_key=True, serialize=False)),
                ('mantenimiento_comentario', models.CharField(max_length=500)),
                ('mantenimiento_fecha', models.DateField()),
                ('mantenimiento_costo', models.DecimalField(decimal_places=2, max_digits=10)),
            ],
            options={
                'db_table': 'mantenimiento',
                'managed': False,
            },
        ),
    ]