# Juego del Dinosaurio en FPGA

Implementación del clásico juego del dinosaurio de Google Chrome utilizando una arquitectura MIPS sobre una FPGA Spartan-6.

El proyecto combina programación en lenguaje ensamblador MIPS, diseño digital en VHDL, control gráfico mediante framebuffer y salida VGA.

## Tecnologías utilizadas

- FPGA Spartan-6
- MIPS
- VHDL
- Lenguaje ensamblador
- MARS
- VGA
- Framebuffer
- Máquinas de estados
- Sistemas digitales

## Funcionamiento

El juego comienza inicializando la posición del dinosaurio y de tres obstáculos.

Durante la ejecución:

- Los obstáculos se desplazan de derecha a izquierda.
- El jugador puede hacer saltar al dinosaurio mediante una tecla.
- Se simula el efecto de gravedad cuando el dinosaurio se encuentra en el aire.
- Se verifica continuamente la existencia de colisiones.
- En caso de colisión, el sistema pasa al estado `Game Over`.
- El juego puede reiniciarse mediante una nueva entrada del usuario.

## Arquitectura

El sistema utiliza una arquitectura MIPS que incluye:

- Program Counter
- Instruction Memory
- Banco de registros
- ALU
- Data Memory
- Unidad de Control
- Control de entrada
- Framebuffer

La salida gráfica utiliza memoria VGA y señales de sincronización horizontal y vertical para visualizar el entorno del juego.

## Simulación

La lógica del juego fue desarrollada y probada inicialmente utilizando MARS.

Para la simulación gráfica se utilizaron:

- Bitmap Display
- Keyboard and Display MMIO Simulator

Esto permitió verificar el movimiento del dinosaurio, los obstáculos, los saltos y la detección de colisiones.

## Implementación en FPGA

El proyecto fue posteriormente llevado a una FPGA Spartan-6 con salida VGA.

La implementación permitió validar la comunicación entre el procesador MIPS, la memoria gráfica y el controlador VGA.

## Archivos

Código ensamblador:

`assembly/dinosaur_game.asm`


## Documentación

El informe completo del proyecto está disponible aquí:

[Ver informe del proyecto](docs/Project_Report.pdf)

## Autores

- Victor Curiel
- Ximena Quenhan

Universidad Nacional de Asunción  
Facultad de Ingeniería  
Ingeniería Mecatrónica

## Licencia

Este proyecto está distribuido bajo la licencia MIT.
