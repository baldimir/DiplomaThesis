import Graphics.UI.GLUT

main :: IO()
main = do 
        _ <- getArgsAndInitialize
        newWindow "HOpenGLExamples - Points"
        mainLoop

-- Hlavna metoda vykreslenia okna a obrazu
newWindow :: String -> IO()
newWindow caption = do
        _ <- createWindow caption
        displayCallback $= drawPoints

-- Metoda pre vykreslenie polygonu         
drawPoints :: IO()         
drawPoints = do
        clearColor $= Color4 0 0 0 1
        clear [ColorBuffer]
        pointSize $= 6
        renderPrimitive Points $mapM_ (\(x, y, z) -> vertex $ Vertex3 x y z) myPoints
        flush
 
-- Vykreslovane body 
myPoints :: [(GLfloat,GLfloat,GLfloat)]
myPoints =
        [(0.76, 0.31, 0.0)
         ,(0.12, -0.15, 0.17)
         ,(0.65, 0.87, -0.31)
         ,(0.18, 0.98, 1.0)]