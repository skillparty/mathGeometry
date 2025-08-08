import { Router } from 'express';
import { 
  getAllPresets, 
  getPresetById, 
  createPreset, 
  updatePreset, 
  deletePreset 
} from '../controllers/presetsController';

const router = Router();

// Get all presets
router.get('/', getAllPresets);

// Get preset by ID
router.get('/:id', getPresetById);

// Create new preset
router.post('/', createPreset);

// Update preset
router.put('/:id', updatePreset);

// Delete preset
router.delete('/:id', deletePreset);

export default router;
