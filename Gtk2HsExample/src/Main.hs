
import Graphics.UI.Gtk
import Graphics.Rendering.Cairo

main :: IO ()
main = do
  initGUI
  builder <- builderNew
  builderAddFromFile builder "gtk2hsExample.glade"
  window <- builderGetObject builder castToWindow "window1"
  onDestroy window (closeAndDestroy window)
  
  -- Nacitame si a inicializujeme kresliacu plochu.
  drawArea <- builderGetObject builder castToDrawingArea "drawArea"
  widgetModifyBg drawArea StateNormal (Color 65535 65535 65535)
  
  -- Tlacidlo pre kreslenie ciary 
  btnLine <- builderGetObject builder castToButton "btnLine"
  onClicked btnLine $ do
        drawAreaDrawCanvas <- drawingAreaGetDrawWindow drawArea
        sbLineSize <- builderGetObject builder castToSpinButton "sbLineSize"
        sbColorRed <- builderGetObject builder castToSpinButton "sbRed"
        sbColorGreen <- builderGetObject builder castToSpinButton "sbGreen"
        sbColorBlue <- builderGetObject builder castToSpinButton "sbBlue"
        lineSize <- spinButtonGetValue sbLineSize
        colorRed <- (spinButtonGetValue sbColorRed)
        colorGreen <- spinButtonGetValue sbColorGreen 
        colorBlue <- spinButtonGetValue sbColorBlue
        drawWindowClear drawAreaDrawCanvas
        renderWithDrawable drawAreaDrawCanvas (myDrawLine lineSize (colorRed/255) (colorGreen/255) (colorBlue/255))
        
  -- Tlacidlo pre kreslenie obdlznika
  btnRect <- builderGetObject builder castToButton "btnRect"
  onClicked btnRect $ do
        drawAreaDrawCanvas <- drawingAreaGetDrawWindow drawArea
        sbLineSize <- builderGetObject builder castToSpinButton "sbLineSize"
        sbColorRed <- builderGetObject builder castToSpinButton "sbRed"
        sbColorGreen <- builderGetObject builder castToSpinButton "sbGreen"
        sbColorBlue <- builderGetObject builder castToSpinButton "sbBlue"
        lineSize <- spinButtonGetValue sbLineSize
        colorRed <- spinButtonGetValue sbColorRed
        colorGreen <- spinButtonGetValue sbColorGreen
        colorBlue <- spinButtonGetValue sbColorBlue
        drawWindowClear drawAreaDrawCanvas
        renderWithDrawable drawAreaDrawCanvas (myDrawRect lineSize (colorRed/255) (colorGreen/255) (colorBlue/255))
          
  widgetShowAll window
  mainGUI

myDrawLine :: Double -> Double -> Double -> Double -> Render ()
myDrawLine lineSize r g b = do
        setSourceRGB r g b
        setLineWidth lineSize
        moveTo 120 60
        lineTo 180 110
        stroke
 
myDrawRect :: Double -> Double -> Double -> Double -> Render ()
myDrawRect lineSize r g b = do
        setSourceRGB r g b
        setLineWidth lineSize
        rectangle 120 60 200 200
        stroke
    
closeAndDestroy w = do 
        widgetDestroy w
        mainQuit   
