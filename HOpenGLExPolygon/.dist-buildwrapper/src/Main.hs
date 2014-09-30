import Graphics.UI.GLUT

main :: IO()
main = do 
        _ <- getArgsAndInitialize
        newWindow "HOpenGLExamples - Polygon"
        mainLoop

-- Hlavna metoda vykreslenia okna a obrazu
newWindow :: String -> IO()
newWindow caption = do
        _ <- createWindow caption
        -- Hlavny callback pre vykreslenie zobrazovanej plochy
        displayCallback $= drawPolygon
         
-- Metoda pre vykreslenie polygonu   
drawPolygon :: IO()     
drawPolygon = do
        clearColor $= Color4 0 0 1 1
        clear [ColorBuffer]
        renderPrimitive Polygon $mapM_ (\(x, y, z) -> vertex $ Vertex3 x y z) myPoints
        flush
   
-- Vykreslovane body polygonu     
myPoints :: [(GLfloat,GLfloat,GLfloat)]
myPoints =
        [(0.25, 0.67, 0.0)
         ,(0.15, 0.50, 0.0)
         ,(0.50, 0.93, 0.0)
         ,(0.76, 0.25, 0.0)]