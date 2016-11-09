# Sistema de recomendación  

> Marcos Carro Fernández    
> marcos.carro.fernandez@rai.usc.es  

<!-- TOC -->

- [Sistema de recomendación](#sistema-de-recomendaci%C3%B3n)
    - [Deseño inicial](#dese%C3%B1o-inicial)

<!-- /TOC -->

Ao longo deste documento detallarase e explicarase a implementación mediante o emprego de **CLIPS** dun sistema de recomendación para un supermercado. Revisaranse dende os aspectos iniciais do deseño ata as últimas consecuencias da implementación, ofrecendo así unha panorámica completa de como foi pensado e deseñado o sistema e en base a que ideas.  

## Deseño inicial
En primeiro lugar debemos realizar un bosquexo xeral da idea que despois nos permitirá ir perfilando o sistema. Basicamente, temos certos elementos que o propio sistema nos esixe de forma inherente a si mesmo para poder converterse nun _Sistema de recomendación_ para un usuario.  

Estos elementos son os seguintes:  
* Usuario  
* Obxectos  
* Carro da compra
* Panel de obxectos recomendados  
* Obxectos dispoñibles no supermercado

Este deseño e estes elementos veñen dados pola seguinte sucesión de feitos: 
 1. Un usuario atópase no supermercado  
 2. O usuario engade elementos ao **carro da compra**  
    2.1. _O sistema recoñece que esos elementos son de interese para o usuario_  
    2.2. _O sistema establece relacións entre as características deses obxectos e os dispoñibles no supermercado_  
    2.3. _O sistema engade ao panel de obxectos recomendados de cada usuario os obxectos que lle son recomendados_  

 
    