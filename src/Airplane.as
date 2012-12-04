package  
{
	import flash.display.Stage;
	import flash.events.Event;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.PaperPlane;
	/**
	 * ...
	 * @author Just
	 */
	public class Airplane extends PaperPlane
	{
        protected var _colorMaterial:ColorMaterial;	
		public var _w:Boolean,  _s:Boolean;
		public var speed:Number = 0;
			
		public function Airplane() 
		{
			
			//Colormaterial for the Paperplane
			_colorMaterial = new ColorMaterial(0xFFF000, 0.5);
			//Make sure its the same on both sides
            _colorMaterial.doubleSided = true;
			//Super function for setting up the Paperplane
			super(_colorMaterial, 8);
		}
		
		//Function that decides on how hard the Airplane has to go when u push W/S
		public function speedPlane(_w:Boolean, _s:Boolean):void
		{
			if(_w )
			{
				//If u press W speed will increase untill "45" and that is also his top
				speed++;
				if (speed > 45) speed = 45;
			}
			else if (_w == false && _s == false && speed > 0)
			{
				speed = speed - 1;
			}
			if (_s)
			{
				//If u press S Speel will decrease till "1" and will stay 1 so it will never stop flying completly
				speed--;
				if (speed < 1) speed = 1;
			}
			
			this.moveForward( speed );
		}
	}
}