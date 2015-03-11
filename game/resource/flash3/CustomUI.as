package {
	import flash.display.MovieClip;

	//import some stuff from the valve lib
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	import flash.utils.getDefinitionByName;
	import LVL.Button;
	import LVL.SmallButton;
	
		
	public class CustomUI extends MovieClip{
		
		//these three variables are required by the engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		var smallbutt01:SmallButton = new SmallButton(gameAPI,globals);
		var button:Button = new Button(gameAPI,globals,smallbutt01);
		
		
		
		//constructor, you usually will use onLoaded() instead
		public function CustomUI() : void {
			
		}
		
		//this function is called when the UI is loaded
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);		
			addChild(button);
			addChild(smallbutt01);
			
			
			
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!");
		}
		
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {
			
			var scaleRatioY:Number = re.ScreenHeight/900;					
                    
            button.screenResize(re.ScreenWidth, re.ScreenHeight, scaleRatioY);
			smallbutt01.screenResize(re.ScreenWidth, re.ScreenHeight, scaleRatioY);
		}
		
		
		
	}
}