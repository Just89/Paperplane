package  
{
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	/**
	 * ...
	 * @author Just
	 */
	public class Skybox extends DisplayObject3D
	{
		private var _mat:BitmapFileMaterial;
        private var _skybox:Plane;
		
		//Images files for the skybox
		private var _front:String = "images/front.jpg";
        private var _back:String = "images/back.jpg";
        private var _left:String = "images/left.jpg";
        private var _right:String = "images/right.jpg";
        private var _top:String = "images/top.jpg";
        private var _bottom:String = "images/bottom.jpg";
		
		//Deciding how big it needs to be
		public var boxZ:int = 20000;	
		public var boxWidth:int = 20000;
        public var boxHeight:int= 20000;
		
		public function Skybox() 
		{	
			//front plane
			_mat = new BitmapFileMaterial(_front);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.z = boxWidth / 2;
            addChild(_skybox);
           
			//back plane
            _mat = new BitmapFileMaterial(_back);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.z =- (boxWidth/2);
            _skybox.rotationY = 180;
			addChild(_skybox);
           
			//left plane
            _mat = new BitmapFileMaterial(_left);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.x =- (boxWidth/2);
            _skybox.rotationY = -90;
            addChild(_skybox);
           
			//right plane
            _mat = new BitmapFileMaterial(_right);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.x = boxWidth/2;
            _skybox.rotationY = 90;
            addChild(_skybox);
            
			//top plane
            _mat = new BitmapFileMaterial(_top);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.y = boxHeight/2;
            _skybox.rotationX = -90;
            addChild(_skybox);
           
			//bottom plane
            _mat = new BitmapFileMaterial(_bottom);
            _skybox = new Plane(_mat,boxWidth,boxHeight,8,8);
            _skybox.y =- (boxHeight/2);
            _skybox.rotationX = 90;
            addChild(_skybox);
		}	
	}
}