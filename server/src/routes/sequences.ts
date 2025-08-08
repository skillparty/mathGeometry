import { Router } from 'express';
import {
  getAllSequences,
  getSequenceById,
  createSequence,
  updateSequence,
  deleteSequence,
  addKeyframe,
  removeKeyframe
} from '../controllers/sequencesController';

const router = Router();

// Sequence routes
router.get('/', getAllSequences);
router.get('/:id', getSequenceById);
router.post('/', createSequence);
router.put('/:id', updateSequence);
router.delete('/:id', deleteSequence);

// Keyframe routes
router.post('/:id/keyframes', addKeyframe);
router.delete('/:id/keyframes/:keyframeId', removeKeyframe);

export default router;
