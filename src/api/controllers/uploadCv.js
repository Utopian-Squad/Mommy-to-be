const path = require("path");
const multer = require("multer");

const ImageType = function (originalUrl) {
  const imageType = originalUrl.split("/")[3];
  return imageType;
};

const imageDestination = function (originalUrl) {
  const imageType = ImageType(originalUrl);
  return `../public/images/${imageType}`;
};

const destination = function (originalUrl) {
  return `../public/cv`;
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const imageTypes = [".jpeg",".jpg",".png",".gif"];
    if(imageTypes.includes(path.extname(
      file.originalname
    ).toLowerCase())){
    cb(null, path.join(__dirname, imageDestination(req.originalUrl)));
  }
    else{
      cb(null, path.join(__dirname, destination(req.originalUrl)));
    }
  },
  filename: function (req, file, cb) {
    const imageTypes = [".jpeg",".jpg",".png",".gif"]
    if(imageTypes.includes(path.extname(
      file.originalname
    ).toLowerCase())){
      cb(
        null,
        `${ImageType(req.originalUrl)}-${Date.now()}-${path.extname(
          file.originalname
        )}` 
      );
    }else{
      cb(
        null,
        `cv-${Date.now()}-${path.extname(
          file.originalname
        )}` 
      );
    }
    
  },
});

const uploadCv = multer({
  storage,
});

module.exports = uploadCv.array("files");
