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
    (assert (item(name hdd)
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


(defrule removeFromRecommendations
    ;we have recommendation panel
    ?p<-(recommendationPanel(userName ?userName)(item $?rItems))
    ;we've got an item
    ?i<-(item(name ?itemName))
     ; The item isn't in the cart
    ?c<-(cart(userName ?userName)(item $?cart))  
    (test(member$ ?itemName $?cart))
    (test(member$ ?itemName $?rItems))
    =>
     (modify ?p (userName ?userName)(item (delete$ $?rItems (member$ ?itemName $?rItems) (member$ ?itemName $?rItems) )))
)

(defrule checkRecomendations
     ?p<-(recommendationPanel(userName ?serName)(item $?rItems))
      (test(member$ (first$ $?rItems) $?rItems))
      =>
     (printout t "This are the recomendations for you, based on your cart: "crlf $?rItems" "crlf)
)
(defrule checkIfElementExist
     ?s<-(supermarketStorage(name ?supermarketName)(item  $?itemS))
    ?c<-(cart(userName ?userName)(item $?cart))
    (not(test(member$ (first$ $?cart) $?itemS)))
    =>
    (printout t "The item "(first$ $?cart)" does not exist!" crlf)
    (modify ?c (userName ?userName)(item (delete$ $?cart 1 1)))
    )

(defrule addToRecommendations
    ;we have recommendation panel
    ?p<-(recommendationPanel(userName ?serName)(item $?rItems))

    ;we've got an item
    ?i<-(item(name ?itemName)(relevantProperties $?tags))
    ?s<-(supermarketStorage(name ?supermarketName)(item  $?itemS))
     (test(member$ ?itemName $?itemS))

    ; The item isn't in the cart
    ?c<-(cart(userName ?userName)(item $?cart))  
    (not(test(member$ ?itemName $?cart)))

    ; We've got another item
    ?i2<-(item(name ?itemName2)(relevantProperties $?tags2))
    (test(member$ ?itemName2 $?itemS))

    ; The second item is in the cart
    (test(member$ ?itemName2 $?cart))
    ;And some of the tags are compatible
    (test(member$ $?tags $?tags2))

    ; And last the item isn't already been recomended!
    (not(test(member$ ?itemName $?rItems)))
    =>
    (modify ?p (userName ?userName)(item (insert$ $?rItems 1 ?itemName)))
    )


(defrule addToCart
     ?s<-(supermarketStorage(name ?supermarketName)(item  $?itemS))
    ?c<-(cart(userName ?userName)(item $?cart))
     =>
     (printout t "Insert an item to add it to the cart: "crlf ?itemS" " crlf)
     (bind ?e(read))
     (modify ?c (userName ?userName)(item (insert$ ?cart 1  ?e)))
)