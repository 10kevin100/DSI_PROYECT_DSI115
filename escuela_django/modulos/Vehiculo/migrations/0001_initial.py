# Generated by Django 4.2.1 on 2023-05-20 01:21

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Vehiculo',
            fields=[
                ('vehiculo_id', models.AutoField(primary_key=True, serialize=False)),
                ('vehiculo_placa', models.CharField(max_length=25, unique=True)),
                ('vehiculo_marca', models.CharField(max_length=25)),
                ('vehiculo_tipo', models.CharField(max_length=11)),
                ('vehiculo_transmision', models.CharField(max_length=10)),
            ],
            options={
                'db_table': 'vehiculo',
                'managed': False,
            },
        ),
    ]
