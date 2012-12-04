package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite
	{
		private var _airplane:Airplane;
		private var _controls:Controls;
		private var _scene:Scene;

		public function Game()
		{
			//Making Airplane
			_airplane = new Airplane();
			
			//Setting the scene
			_scene = new Scene(_airplane);
			addChild(_scene);
			
			//Creating the scene and setting airplane as target
			_scene.createScene(_airplane);
			
			//Setting up controls, telling that Airplane needs to be controlled and setting the stage
			_controls = new Controls(_airplane, this.stage);
			
			addEventListener(Event.ENTER_FRAME, skyboxBorder);
		} 
		
		//Function that makes sure the Airplane cant leave his skybox
		private function skyboxBorder(e:Event):void 
		{
			//trace(_airplane.x, _airplane.y, _airplane.z);
			if (_airplane.x < -9000 || _airplane.x > 9000)
			{
				_airplane.speed = 0;
			}
			if(_airplane.y < -9000 || _airplane.y > 9000)
			{
				_airplane.speed = 0;
			}
			if(_airplane.z < -9000|| _airplane.z > 9000)
			{
				_airplane.speed = 0;
			}
		}
	}
}