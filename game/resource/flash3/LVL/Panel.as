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
	public class Panel extends Sprite 
	{	
		private var gameAPI:Object;
		private var globals:Object;
		private var _btn1:VButton;
		private var _btn2:VButton;
		
		public function Panel( gameAPI:Object, globals:Object ) 
		{
			super();
			
			this.gameAPI = gameAPI;
			this.globals = globals;
			visible = false;
			
			// Background
			var bg:VComponent = new VComponent( "bg_overlayBox" );
			addChild( bg );
			bg.height = 400;
			bg.width = 400;
			
			var label:TextField = Utils.CreateLabel( "Ability Panel", FontType.TextFont );
			var tf:TextFormat = new TextFormat();
			tf.size = 24;
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xEA7070;
			tf.font = FontType.TextFont;
			label.setTextFormat( tf );
			//label.y = 30;
			//label.width = 400;
			label.alpha = 0.9;
			label.filters = [ new GlowFilter() ];
			addChild( label );
			
			_btn1 = new VButton( "chrome_button_primary", "YES" );
			//_btn1.x = 125 + 4;
			//_btn1.y = 95 + 2;
			addChild( _btn1 );

			_btn2 = new VButton( "chrome_button_normal", "NO" );
			//_btnNo.x = 275;
			//_btnNo.y = 95;
			addChild( _btn1 );
			
			// Register event listeners
			_btn1.addEventListener( ButtonEvent.CLICK, _onClick1 );
			_btn1.addEventListener( ButtonEvent.CLICK, _onClick2 );
			
		}
		
		public function toggle()
		{			
			if(this.visible)
			{
				_btn1.enabled = true;
				_btn2.enabled = true;
				visible = true;
			}
			else
			{	
				_btn1.enabled = true;
				_btn2.enabled = true;
				visible = true;
			}
		}
		
		private function _onClick1( e:ButtonEvent ):void 
		{
			gameAPI.SendServerCommand( "1" );
			this.toggle();
		}
		
		private function _onClick2( e:ButtonEvent ):void 
		{
			gameAPI.SendServerCommand( "2" );
			this.toggle();
		}
		
	}

}