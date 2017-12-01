#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

Main()

Func Main()
	Local $window_Width = 200
	Local $window_Height = 200
	Local $window_name = "IdleShield"
	Local $hGUI = GUICreate($window_name, $window_Width, $window_Height, -1, -1)
	Local $loopSleep = 50
	Local $movePeriod = 3 * 1000
	
	Local $LastRelativeMouseX = 0
	Local $LastRelativeMouseY = 0
	
	Local $timer = TimerInit()
	
	; 0 = relative coords to the active window
	; 1 = (default) absolute screen coordinates
	; 2 = relative coords to the client area of the active window
	Opt("MouseCoordMode",0)
	
	$label = GUICtrlCreateLabel("", 10, 10, 40, 40)

	GUISetState(@SW_SHOW, $hGUI)
	; Run the GUI until the dialog is closed
	While 1
		If TimerDiff($timer) > $movePeriod Then
			$timer = TimerInit()
			If WinActive($window_name) Then
				$MousePos = MouseGetPos()
				$LastRelativeMouseX = $MousePos[0]
				$LastRelativeMouseY = $MousePos[1]
				If $LastRelativeMouseX > 0 And $LastRelativeMouseX < $window_Width And $LastRelativeMouseY > 0 And $LastRelativeMouseY < $window_Height Then
					MouseMove( $LastRelativeMouseX + 100, $LastRelativeMouseY, 4 )
					MouseMove( $LastRelativeMouseX, $LastRelativeMouseY, 4 )
				EndIf
			EndIf
		EndIf
		GUICtrlSetData($label, StringFormat("%06.3f", ($movePeriod - TimerDiff($timer))/1000.0))
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
		
		Sleep($loopSleep)
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc	;==>Main
