# Generated by Django 4.2.1 on 2023-06-02 23:30

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Encuesta',
            fields=[
                ('encuesta_id', models.AutoField(primary_key=True, serialize=False)),
                ('encuesta_fecha', models.DateField(auto_now_add=True)),
                ('pregunta1', models.IntegerField()),
                ('pregunta2', models.IntegerField()),
                ('pregunta3', models.IntegerField()),
                ('pregunta4', models.IntegerField()),
                ('pregunta5', models.IntegerField()),
                ('pregunta6', models.IntegerField()),
                ('pregunta7', models.IntegerField()),
                ('encuesta_comentario', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'encuesta',
                'managed': False,
            },
        ),
    ]
