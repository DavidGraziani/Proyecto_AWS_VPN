                                                  Proyecto AWS VPN Site to Site

Explicacion de los pasos a seguir luego de aplicar un terraform apply al script. Es sencillo crear la conexion VPN site to site y configurar los equipos a los que se realizara la conexion, lo primero que debemos hacer es ir al apartado de aws en VPN connection y descargar el txt, luego hay que elegir el tipo de dispositivo y la version para pasar a configurar seguiendo la documentacion de configuracion (como se muestra en la imagen), tambien haber creado las politicas de salidas y entradas para los 2 tunnels, y estaria listo para hacer la prueba de conexion. Favor seguir las imagenes: 

ir a Download Configuration.

![image](https://github.com/user-attachments/assets/6c4d4a7d-54a4-40fa-9438-47143ad81311)

Aqui elija el equipo al configurar y la version.

![image](https://github.com/user-attachments/assets/d2e18f0e-26b8-4f1f-bf1e-03a2e16eb3f3)

Y seguir los paso de la configuracion segun el txt.

![image](https://github.com/user-attachments/assets/393f204e-e8fb-4232-b7be-74810803536a)



                                                Digrama de toda la implementación 
![image](https://github.com/user-attachments/assets/23948283-e5ce-4069-828a-7bcf2c3f547b)
