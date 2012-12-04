package  
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.stats.StatsView;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.core.clipping.FrustumClipping;
	import org.papervision3d.cameras.SpringCamera3D;
	import org.papervision3d.view.Viewport3D;
	/**
	 * ...
	 * @author Just
	 */
	public class Scene extends Viewport3D
	{
		private var _springCamera:SpringCamera3D;
		private var _renderer:BasicRenderEngine;
		private var _scene:Scene3D;
		private var _viewport:Viewport3D;
		
		private var _statsview:StatsView;
		
		private var _timerText:TextField;
		private var _timerTextformat:TextFormat;
		
		private var _timer:Timer;
		private var _totalSecondsLeft:Number;
		//you begin the game with 1minute;
		private var _startTime:Number = 61;
		private var _timerSpeed:Number = 650;
		
		private var _imageLoader:Loader = new Loader();
		private var _image:URLRequest = new URLRequest("images/circle2.png");
		private var _counterText:TextField;
		private var _count:int = 0;
		
		private var _airplane:Airplane;
		private var _skybox:Skybox;
		private var _controls:Controls;
		private var _circle:Circle;
		
		private var _endgame:Sprite = new Sprite();
		private var _endgameText:TextField = new TextField();
		
		//The function scene always needs his airplane to function
		public function Scene(airplane:Airplane) 
		{	
			_airplane = airplane;
			
			//Super function for setting up the Viewport3D
			super(800, 600, true);
					
			//Event that places the correct things on the stage
			addEventListener(Event.ADDED_TO_STAGE, setupScene);
			//Event that repeats itself every frame
			addEventListener(Event.ENTER_FRAME, onRenderTick);
			//Start timer when game begins
			timer();
		}

		//Basic Pv3D stuff, setting up the renderengine, scene and springcamera
		private function setupScene(e:Event):void
		{
			_renderer = new BasicRenderEngine();
			_scene = new Scene3D();

			_springCamera = new SpringCamera3D();
			_springCamera.mass = 10;
			_springCamera.damping = 10;
			_springCamera.stiffness = 1;
			_springCamera.positionOffset.x = 0;
			_springCamera.positionOffset.y = 200;
			_springCamera.positionOffset.z = -2000;
		}
		
		//Creating the scene
		public function createScene(airplane:Airplane):void
		{
			//Putting the skybox (level) on the scene
			_skybox = new Skybox()
			_scene.addChild(_skybox);
			
			//Statsview to check the FPS, memmory etc.
			_statsview = new StatsView(_renderer);
			//addChild(_statsview);
			
			//Placing the donut u need to fly through on the scene
			_circle = new Circle(_skybox);
			_scene.addChild(_circle);
			
			//Adding Airplane wich is the target on the scene
			_scene.addChild(airplane);
			
			//Setting the target wich the springcamera needs to follow
			_springCamera.target = airplane;
			
			//Timer's textfield
			_timerText = new TextField();
			_timerText.x = 700;
			
			//countertext
			_counterText = new TextField();
			_counterText.x = 600;

			//Textformat for textfield
			_timerTextformat = new TextFormat();
			_timerTextformat.size = 45;
			_timerTextformat.font = "Calibri";
			_timerText.defaultTextFormat = _timerTextformat;
			
			//Little rainbow circle next to the counter
			_imageLoader.load(_image);
			_imageLoader.x = 540;
			_imageLoader.y = 11.5;
			addChild(_imageLoader);
			
			//Countertext + format
			_counterText.defaultTextFormat = _timerTextformat;
			_counterText.text = String(_count);
			
			addChild(_counterText);
			addChild(_timerText);
		}
		
		//Timer 
		private function timer():void
		{
			_timer = new Timer(_timerSpeed);
			_timer.addEventListener(TimerEvent.TIMER, timerListener);
			_timer.start();
		}
		
		private function timerListener(event:TimerEvent):void 
		{
			_totalSecondsLeft = _startTime - _timer.currentCount;
			_timerText.text = timeFormat(_totalSecondsLeft);
			
			//Announce that u have 10sec left
			if (_totalSecondsLeft <= 10) 
			{ 
				_timerText.textColor = 0xFF0000;
			}
			//If 0sec left stop game
			if (_totalSecondsLeft == 0) 
			{ 
				_timer.stop();
				
				//Removing the game
				_scene.removeChild(_airplane);
				_scene.removeChild(_skybox);
				_scene.removeChild(_circle);
				removeChild(_counterText);
				removeChild(_timerText);
				removeChild(_imageLoader);
				
				//End Screen
				_endgame.graphics.beginFill(0x000000);
				_endgame.graphics.drawRect(0, 0, 1500, 1500);
				_endgame.graphics.endFill();
				
				//End text
				_endgameText.x = 325;
				_endgameText.y = 250;
				_endgameText.width = 500;
				_endgameText.height = 500;
				_endgameText.multiline = true;
				_endgameText.wordWrap = true;
				_endgameText.text = "Game Over!! Your score is: " + _count;
				_endgameText.textColor = 0xFFFFFF;
								
				addChild(_endgame);
				addChild(_endgameText);
				
			}
		}
		//Setting a format for the timer
		private function timeFormat(seconds:int):String 
		{
			var minutes:int;
			var sMinutes:String;
			var sSeconds:String;
			if(seconds > 59) {
				minutes = Math.floor(seconds / 60);
				sMinutes = String(minutes);
				sSeconds = String(seconds % 60);
			} else {
				sMinutes = "0";
				sSeconds = String(seconds);
			}
			if(sSeconds.length == 1) {
				sSeconds = "0" + sSeconds;
			}
			return sMinutes + ":" + sSeconds;
		}
			
       	//Hittest function, if the Airplane hits the circle, the circle will take another random position
		private function hitTest():void
      	 {
			if (_airplane.hitTestObject(_circle))
			{
				//adding up 5sec when u hit the circle
				_startTime += 6;
				
				_count++;
				_counterText.text = String(_count);
				
				//Placing the circle in anoter random location when hit
				_circle.x = Math.random() * (_skybox.boxWidth - 12000);
				_circle.y = Math.random() * (_skybox.boxHeight - 12000);
				_circle.z = Math.random() * (_skybox.boxZ - 12000);
			}
        }
		
		//Function that decides what needs to be done for every frame
		protected function onRenderTick(event:Event = null):void
		{
			//Executing the hitTest() for every frame
			hitTest();
			//Adds a Polycount to the statsview
			_statsview.updatePolyCount(_scene);
			//Starts rendering
			_renderer.renderScene(_scene, _springCamera, this);
		}
	}
}