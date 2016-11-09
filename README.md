# Sistema de recomendación  

> Marcos Carro Fernández    
> marcos.carro.fernandez@rai.usc.es  

<!-- TOC -->

- [Sistema de recomendación](#sistema-de-recomendaci%C3%B3n)
    - [Deseño inicial](#dese%C3%B1o-inicial)
    - [Codificación](#codificaci%C3%B3n)
        - [Creación das plantillas iniciais](#creaci%C3%B3n-das-plantillas-iniciais)
        - [Creación de reglas](#creaci%C3%B3n-de-reglas)

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

 
## Codificación  
A partires das ideas iniciais que plantexamos no apartado anterior, iremos codificando e modificando conforme nos vamos encontrando con novas ideas o plantexamento do que partimos inicialmente.  

### Creación das plantillas iniciais  
Como mencionamos ao principio, é vital deseñar unhas plantillas coas que se poida traballar, para iso, comezamos en primeiro lugar definindo as seguintes:  

* Unha plantilla **item** que conterá un nome identificativo e un conxunto de _propiedades_ relevantes que permitirá a relación entre os distintos ítems.  
```CLIPS 
(deftemplate item
    (slot name)
    (multislot relevantProperties)
    )
```
* **REVISAR!!!**
```CLIPS 
(deftemplate supermarketStorage
    (slot name)
    (multislot item))
```
* Unha plantilla **recomendationPanel** que almacenará os obxectos que son suxeridos ao usuario.  
```CLIPS 
(deftemplate recommendationPanel
    (slot userName)
    (multislot item))
```
* Unha plantilla **cart** que almacenará os obxectos que o usuario irá seleccionando no supermercado.  
```CLIPS 
(deftemplate cart
    (slot userName)
    (multislot item))
```
* A propia plantilla de **user** que conterá ademais dun identificador de usuario que será o nome, unha referencia ao seu carrito da compra feita a través do slot **cart** e unha referencia ao seu panel de recomendación feita a través do seu slot **recomendationPanel**  
```CLIPS 
(deftemplate user
    (slot name)
    )
```
```CLIPS 
```    

### Creación de reglas  
Neste apartado indicaránse que reglas se estableceron e o porque das mesmas.  

1. A primeira regla inicializa tanto o carro como o panel de recomendación ao engadir un usuario  
```CLIPS 
(defrule intializeUser
    ?u<-(user(name ?userName)(cart nil)(recommendationPanel nil))
    =>
    (modify ?u (cart 1)(recommendationPanel 1))
    (assert (cart(userName ?userName)))
    (assert (recommendationPanel(userName ?userName)))
   ) 
``` 
