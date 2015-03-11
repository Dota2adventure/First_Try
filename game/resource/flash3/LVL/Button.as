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
	import LVL.SmallButton;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Button extends Sprite 
	{	
		private var gameAPI:Object;
		private var globals:Object;
		var smallbutt01:SmallButton = new SmallButton(gameAPI,globals);
		
		public function Button( gameAPI:Object, globals:Object,smallbutt01:SmallButton) 
		{
			super();
			
			this.gameAPI = gameAPI;
			this.globals = globals;
			visible = true;
			
			var butt:VButton = new VButton( "chrome_button_normal","Abilities");
			addChild( butt );

			
			// Register event listeners
			butt.addEventListener( ButtonEvent.CLICK, _onClickButt);
			
		}		
		
		private function _onClickButt( e:ButtonEvent ):void 
		{
			smallbutt01.toggle();
		}		
		
		public function screenResize(stageW:int, stageH:int, scaleRatio:Number){
			this.x = 0.89 * stageW;
			this.y = 0.76 * stageH;

			this.width = 0.11 * stageW;
			this.height = 0.03 * stageH;
			
			smallbutt01.screenResize(stageW,stageH,scaleRatio);
		}
		
	}

}