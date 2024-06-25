import 'package:flutter/material.dart';

class TermsScreenTenant extends StatelessWidget {
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
              'Términos y Condiciones para Arrendadores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 1),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: '''

1.	Introducción
Bienvenido a AutoYa. Estos Términos y Condiciones (en adelante, los "Términos") regulan el uso de nuestra plataforma por parte de los arrendatarios (en adelante, el "Arrendatario"). Al registrarse y utilizar la plataforma, usted acepta estos Términos en su totalidad.

2. Registro y Obligaciones del Arrendatario
Elegibilidad: El Arrendatario debe tener al menos 18 años y poseer una licencia de conducir válida.
Información Veraz: El Arrendatario garantiza que toda la información proporcionada durante el registro es verdadera, precisa y completa.
Actualización de Información: El Arrendatario se compromete a mantener actualizada la información de su perfil.

3. Reservas y Uso del Vehículo
Reserva: El Arrendatario puede reservar vehículos a través de la plataforma siguiendo los procedimientos establecidos.
Condiciones de Uso: El Arrendatario se compromete a utilizar el vehículo de manera responsable y de acuerdo con las leyes de tránsito locales.
Devolución del Vehículo: El Arrendatario debe devolver el vehículo en el mismo estado en que lo recibió, salvo el desgaste normal por uso.

4. Política de Precios y Pagos
Determinación de Precios: Los precios del alquiler serán determinados por el Propietario y mostrados en la plataforma.
Pagos: Los pagos se realizarán a través de la plataforma. El Arrendatario autoriza a la plataforma a realizar los cargos correspondientes a su método de pago registrado.

5. Responsabilidades del Arrendatario
Cuidado del Vehículo: El Arrendatario es responsable del cuidado y custodia del vehículo durante el período de alquiler.
Seguro: El Arrendatario debe asegurarse de que el vehículo cuenta con un seguro vigente proporcionado por el Propietario. En caso de daños, el Arrendatario deberá cubrir los costos no cubiertos por el seguro.
Multas y Sanciones: El Arrendatario es responsable de cualquier multa o sanción incurrida durante el uso del vehículo.

6. Terminación y Modificación de los Términos
Terminación del Servicio: AutoYa se reserva el derecho de suspender o cancelar el acceso del Arrendatario a la plataforma en caso de incumplimiento de estos Términos.
Modificaciones: AutoYa puede modificar estos Términos en cualquier momento. Las modificaciones serán notificadas al Arrendatario, quien deberá aceptarlas para continuar utilizando la plataforma.

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
