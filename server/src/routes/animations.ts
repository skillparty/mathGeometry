import { Router } from 'express';
import { 
  getAllAnimations,
  getAnimationById,
  createAnimation,
  updateAnimation,
  deleteAnimation
} from '../controllers/animationsController';

const router = Router();

// Get all animations
router.get('/', getAllAnimations);

// Get animation by ID
router.get('/:id', getAnimationById);

// Create new animation
router.post('/', createAnimation);

// Update animation
router.put('/:id', updateAnimation);

// Delete animation
router.delete('/:id', deleteAnimation);

export default router;
