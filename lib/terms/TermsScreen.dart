import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones'),
        backgroundColor: Color.fromARGB(255, 19, 19, 19),
        actions: [
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Términos y Condiciones para Propietarios de Autos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: '''
1. Introducción
Bienvenido a AutoYa. Estos Términos y Condiciones (en adelante, los "Términos") regulan el uso de nuestra plataforma por parte de los propietarios de autos (en adelante, el "Propietario"). Al registrarse y utilizar la plataforma, usted acepta estos Términos en su totalidad.

2. Registro y Obligaciones del Propietario
Elegibilidad: El Propietario debe tener al menos 18 años y ser el titular legal del vehículo.
Información Veraz: El Propietario garantiza que toda la información proporcionada durante el registro es verdadera, precisa y completa.
Actualización de Información: El Propietario se compromete a mantener actualizada la información de su perfil y de su vehículo.

3. Listado de Vehículos
Condiciones del Vehículo: El Propietario debe asegurar que el vehículo esté en condiciones seguras y adecuadas para el alquiler.
Documentación: El Propietario debe proporcionar la documentación necesaria, incluyendo la matrícula, seguro y cualquier otra requerida por la plataforma.
Responsabilidad: El Propietario es responsable de cualquier daño o desperfecto del vehículo que no sea causado por el Arrendatario durante el período de alquiler.

4. Política de Precios y Pagos
Determinación de Precios: El Propietario puede establecer el precio del alquiler de su vehículo. La plataforma puede sugerir precios basados en el mercado.
Pagos: Los pagos se realizarán a través de la plataforma, que retendrá una comisión por sus servicios. Los pagos al Propietario se realizarán en los plazos establecidos en la plataforma.

5. Responsabilidades del Propietario
Mantenimiento del Vehículo: El Propietario debe mantener el vehículo en condiciones óptimas de funcionamiento.
Seguro: El Propietario debe contar con un seguro vigente que cubra posibles daños durante el período de alquiler.
Asistencia: El Propietario debe estar disponible para resolver cualquier inconveniente que el Arrendatario pueda tener con el vehículo durante el alquiler.

6. Terminación y Modificación de los Términos
Terminación del Servicio: AutoYa se reserva el derecho de suspender o cancelar el acceso del Propietario a la plataforma en caso de incumplimiento de estos Términos.
Modificaciones: AutoYa puede modificar estos Términos en cualquier momento. Las modificaciones serán notificadas al Propietario, quien deberá aceptarlas para continuar utilizando la plataforma.

7. Ley Aplicable y Jurisdicción
Estos Términos se regirán e interpretarán de acuerdo con las leyes del país en el que opera la plataforma. Cualquier disputa derivada de estos Términos será resuelta en los tribunales competentes del mismo país.
''',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
