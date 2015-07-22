(define (problem task4)
   (:domain chameleonWorld)
   (:objects
         door1 - door
         flexarium1 - flexarium
         veiledChameleon - chameleon
         box1 box2 - box
         newsPaper1 newsPaper2 - substrate
        )
    (:init
        (doorClosed door1)
        (dirty flexarium1)
        (inBox veiledChameleon box1)
        (boxClosed box1)
        (boxClosed box2)
        (insideFlexarium newsPaper1)
        (outsideFlexarium newsPaper2)
        )
    (:goal
      (and
        (doorClosed door1)
        (dirty flexarium1)
        (inBox veiledChameleon box2)
        (boxClosed box1)
        (boxClosed box2)
        (insideFlexarium newsPaper1)
        (outsideFlexarium newsPaper2)
       ))
)
