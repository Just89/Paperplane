package  
{
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.objects.primitives.Plane;
	/**
	 * ...
	 * @author Just
	 */
	public class Circle extends Plane
	{
		protected var _mat:BitmapFileMaterial;
		protected var _circleWidth:int = 1000;
        protected var _circleHeight:int = 1000;
		
		private var _circle:Plane;
		private var _circleImg:String = "images/circle.png";
		
		private var _skybox:Skybox;
		
		//The circle will always be placed inside the skybox
		public function Circle(skybox:Skybox) 
		{
			_skybox = skybox;
			
			//Adding a picture on the circle
			_mat = new BitmapFileMaterial(_circleImg);
			//Make sure its the same on both sides
			_mat.doubleSided = true;
			//Super function for setting up the Plane
			super(_mat, _circleWidth, _circleHeight);
			//Placing the circle on a random place inside the skybox
			this.x = Math.random() * (_skybox.boxWidth - 12000);
			this.y = Math.random() * (_skybox.boxHeight - 12000);
			this.z = Math.random() * (_skybox.boxZ - 12000);
		}
	}
}