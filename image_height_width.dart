    final decodedImage =
	    await decodeImageFromList(file.readAsBytesSync()); //? image from file
	if (decodedImage.width != 100 ||
	 decodedImage.height != 100) { }  
