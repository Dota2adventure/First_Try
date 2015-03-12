package LVL
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import scaleform.clik.events.ButtonEvent;
	import vcomponents.VButton;
	import vcomponents.VComponent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class SmallButton extends Sprite 
	{	
		private var gameAPI:Object;
		private var globals:Object;
		
		public function SmallButton( gameAPI:Object, globals:Object ) 
		{
			super();
			
			this.gameAPI = gameAPI;
			this.globals = globals;
			visible = true;
			
			var butt1a:VButton = new VButton( "chrome_button_primary","LOL");
			addChild( butt );
			
			butt1a.enabled = false;			
			// Register event listeners
			butt1a.addEventListener( ButtonEvent.CLICK, _onClickButt);
					
		}
				
		private function _onClickButt( e:ButtonEvent ):void 
		{
			trace("Small Button pressed!!!");
		}		
		
		public function screenResize(stageW:int, stageH:int, scaleRatio:Number){
			this.x = 0.5 * stageW;
			this.y = 0.82 * stageH;

			this.width = 0.11 * stageW;
			this.height = 0.03 * stageH;
		}
		
		public function toggle(){
			if(this.visible){
				this.visible = false;
			}else{
				this.visible = true;
			}
		}
		
	}

}