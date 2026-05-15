import { Router } from "express";
import * as albumsController from "./albums.controller";
import { authMiddleware } from "../../middlewares/auth.middleware";
import { validate } from "../../middlewares/validate.middleware";
import { addTripPhotoSchema } from "./albums.validation";

const router = Router();

router.use(authMiddleware);

router.post("/", albumsController.createAlbum);
router.get("/", albumsController.getAlbums);
router.post(
  "/photos",
  validate(addTripPhotoSchema),
  albumsController.addTripPhoto,
);
router.get("/photos/list", albumsController.getPhotos);
router.post("/photos/:id/like", albumsController.togglePhotoLike);
router.get("/:id", albumsController.getAlbumById);
router.post("/:id/photos", albumsController.addPhotoToAlbum);

export default router;
