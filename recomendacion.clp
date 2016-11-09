; First the templates that are going to be used are defined
; The item name only has the fields name to identify it and the multislot relvant properties that helps relating it with another objects
(deftemplate item
    (slot name)
    (multislot relevantProperties)
    )

(deftemplate supermarketStorage
    (slot name)
    (multislot item))

(deftemplate recommendationPanel
    (slot userName)
    (multislot item))

(deftemplate cart
    (slot userName)
    (multislot item))


(deftemplate user
    (slot name)
    (slot cart)
    (slot recommendationPanel)
    )


; Beggining of the rule section  
(defrule initialR
	(initial-fact)
	=>
    (assert (supermarketStorage(name Gadis)))
    (assert (user(name Marcos)))
    (assert (item(name ssd)
    (relevantProperties 
    electronica disco duro estado solido ordenador almacenamiento)))
    )

(defrule secondR
	(initial-fact)
    ?i<-(item(name ?itemName))
    ?s<-(supermarketStorage(name ?supermarketName)(item  $?itemS))
    (not(test(member$ ?itemName $?itemS)))
	=>
    (modify ?s (name ?supermarketName)(item (insert$ ?itemS 1  ?itemName)))
    )

;First the user is intialized and so are his cart and recommendationPanel
(defrule initializeUser
    ?u<-(user(name ?userName)(cart nil)(recommendationPanel nil))
    =>
    (modify ?u (cart 1)(recommendationPanel 1))
    (assert (cart(userName ?userName)))
    (assert (recommendationPanel(userName ?userName)))
   )  


(defrule addToCart
    ?i<-(item(name ?itemName))
    ?s<-(supermarketStorage(name ?supermarketName)(item  $?itemS))
    (test(member$ ?itemName $?itemS))
    ;?u<-(user(name ?userName)(cart $?cart)(recommendationPanel ~nil))
    ?c<-(cart(userName ?userName)(item $?cart))
    (not(test(member$ ?itemName $?cart)))
    =>
    ;(printout t "Bon dia "?userName", quere engadir "?itemName" ao carro?  (si no) ")
     (modify ?c (userName ?userName)(item (insert$ ?cart 1  ?itemName)))
   )



