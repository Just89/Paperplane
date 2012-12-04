package  
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import org.papervision3d.objects.primitives.PaperPlane;
	/**
	 * ...
	 * @author Just
	 */
	public class Controls
	{
		private var _airplane:Airplane;
		private var _skybox:Skybox;
		
		public var _keylistener:Stage;
		
		//Controls always need to control something, in this case Airplane wich listens to the keys from the stage
		public function Controls(airplane:Airplane, keyListener:Stage)
		{
			_keylistener = keyListener;
			_airplane = airplane;
			
			//Event key down
			keyListener.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
			//Event key release
			keyListener.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
			//Event that repeats itself every frame
			keyListener.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			//Executing speed function
			_airplane.speedPlane(_airplane._w, _airplane._s);
			
			//Mouse controlling moving up/down
			var x:Number = (300 - _keylistener.mouseY) / 75;
			
			_airplane.rotationX -= x;
			
			//Setting boundries to the moving up/down so that the plane wont flip backwards
			if (_airplane.rotationX < -80)
			{
				_airplane.rotationX = -80;
			}
			if (_airplane.rotationX > 80)
			{
				_airplane.rotationX = 80;
			}
			
			//Mouse controlling moving left/right
			var y:Number = (400 - _keylistener.mouseX) / 75;
			
			_airplane.rotationY -= y;
		}
				
		//Handeling keyboard events for pressing a key
		public function stage_keyDownHandler( event :KeyboardEvent ):void
		{
			switch( event.keyCode )
			{
				case 83: //s
					_airplane._s = true;
				break;
				case 87: //w
					_airplane._w = true;
				break;
			}
		}
		
		//Handeling keyboard events for releasing a key
		public function stage_keyUpHandler( event :KeyboardEvent ):void
		{
			switch( event.keyCode )
			{
				case 83: //s
					_airplane._s = false;
				break;
				case 87: //w
					_airplane._w = false;
				break;
			}
		}
	}
}