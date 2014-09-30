import Graphics.UI.GLUT
import Data.IORef

-- predvoleny cas casovaca - urceny na pravidelne prekreslenie vykreslovanej plochy
_TIMER_TIME :: Timeout
_TIMER_TIME = 50

main :: IO()
main = do 
        _ <- getArgsAndInitialize
        -- nastavenie dvojiteho bufferu obrazu -  aby neblikal
        -- a zapnutie hlbkoveho buffera obrazu
        initialDisplayMode $= [DoubleBuffered, WithDepthBuffer]
        newWindow "HOpenGLExamples - Points"
        mainLoop

-- Hlavna metoda vykreslenia okna a obrazu
newWindow :: String -> IO()
newWindow caption = do
        _ <- createWindow caption
        -- funkcia pre zobrazovanie hlbky obrazu
        depthFunc $= Just Less
        -- definovanie novej premennej prostredia - uhol otacania
        angle <- newIORef 1
        -- nastavenie pohladu kamery - pre predvolenu kameru zakomentovat
        lookAt (Vertex3 0.3 (-0.1) 0.0) (Vertex3 0.0 0.0 0.0) (Vector3 0.0 1.0 0.0)
        -- prvotne vykreslenie obrazu
        displayCallback $= rotatedCube angle
        -- casovac na prekreslenie - pre zrusenie otacania kocky zakomentovat
        addTimerCallback _TIMER_TIME basicRedisplay
     
-- Metoda vykreslenia kocky a jej otocenia
rotatedCube :: IORef GLfloat -> IO()     
rotatedCube angleLocal = do
        angleRefValue <- readIORef angleLocal
        -- transformacia otocenia okolo osi y o zadany uhol - pre zrusenie transformacie zakomentovat
        rotate angleRefValue $Vector3 0 (1::GLfloat) 0
        drawCube 
     
drawCube :: IO()    
drawCube = do
        clearColor $= Color4 0 0 0 1
        clear [ColorBuffer, DepthBuffer]
        renderObject Wireframe$ Cube 0.6
        swapBuffers
       
-- metoda na znovuzobrazenie a znovuinicializovanie casovaca
basicRedisplay :: IO()       
basicRedisplay = do
        postRedisplay Nothing
        addTimerCallback _TIMER_TIME basicRedisplay