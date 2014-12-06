package arsupport.demo.away3dlite
{
	import arsupport.ARAway3DLiteContainer;
	import away3dlite.materials.Material;

	import away3dlite.core.base.Mesh;
	import away3dlite.core.base.Object3D;
	import away3dlite.containers.ObjectContainer3D;
	import away3dlite.core.utils.Cast;
	import away3dlite.loaders.Collada;
	import away3dlite.loaders.data.MaterialData;
	import away3dlite.materials.BitmapMaterial;
	
	import nochump.util.zip.*;
	import flash.utils.IDataInput;
	
	import flash.display.Bitmap;

	/**
	 * @author Eugene Zatepyakin
	 */
	public class PinkieAR extends ARAway3DLiteContainer
	{
		
		[Embed(source = "../../../../assets/pinkie/pinkie_pie_body.png")] private static var bodyTexture:Class;
		[Embed(source = "../../../../assets/pinkie/pinkie_pie_eyes.png")] private static var eyesTexture:Class;
		[Embed(source = "../../../../assets/pinkie/pinkie_hair.png")] private static var hairFrontTexture:Class;
		[Embed(source = "../../../../assets/pinkie/pinkie_tail.png")] private static var tailTexture:Class;
		
		//[Embed(source="../../../../assets/pinkie/model.dae", mimeType="application/octet-stream")] private static var Charmesh:Class;
		[Embed(source="../../../../assets/pinkie/model.zip", mimeType="application/octet-stream")] private static var modelZip:Class;
		
		private var collada:Collada;
		private var model:ObjectContainer3D;
		
		private var bodyMaterial:BitmapMaterial;
		private var eyesMaterial:BitmapMaterial;
		private var hFrontMaterial:BitmapMaterial;
		private var tailMaterial:BitmapMaterial;
		
		public var world3d:World3D;
		
		public function PinkieAR(world3d:World3D)
		{
			super();
			
			this.world3d = world3d;
			
			initObjects();
		}
		
		private function initObjects():void
		{
			
			collada = new Collada();
			collada.scaling = 30;
			
			var modelZipObject:Object = new modelZip();
			
			var zip:ZipFile = new ZipFile(modelZipObject as IDataInput);
			for each(var entry:ZipEntry in zip.entries)
			{
				model = collada.parseGeometry(zip.getInput(entry)) as ObjectContainer3D;
			}
			
			model.mouseEnabled = false;
			
			bodyMaterial = new BitmapMaterial(Bitmap(new bodyTexture()).bitmapData);
			eyesMaterial = new BitmapMaterial(Bitmap(new eyesTexture()).bitmapData);
			hFrontMaterial = new BitmapMaterial(Bitmap(new hairFrontTexture()).bitmapData);
			tailMaterial = new BitmapMaterial(Bitmap(new tailTexture()).bitmapData);
			
			//var mat:BitmapMaterial = new BitmapMaterial(Cast.bitmap(Charmap));
        	
			model.rotationX = -90;
			model.rotationZ = 90;
			
			model.materialLibrary.getMaterial("bodyMaterial-material").material = bodyMaterial;
			model.materialLibrary.getMaterial("eyesMaterial-material").material = eyesMaterial;
			model.materialLibrary.getMaterial("hairMaterial-material").material = hFrontMaterial;
			model.materialLibrary.getMaterial("tailMaterial-material").material = tailMaterial;
			
			this.addChild(model);
			
		}
	}
}
