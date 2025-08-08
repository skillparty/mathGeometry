export interface Preset {
  id: number;
  name: string;
  config_json: any;
  created_at: Date;
  updated_at?: Date;
}

export interface Animation {
  id: number;
  preset_id: number;
  timeline_data: any;
  duration: number;
  created_at: Date;
  updated_at?: Date;
}

export interface FractalConfig {
  id: number;
  algorithm: string;
  parameters: any;
  iterations: number;
  created_at: Date;
}

export interface RecordedSequence {
  id: number;
  name: string;
  sequence_data: any;
  duration: number;
  created_at: Date;
  updated_at?: Date;
}

export interface SequenceKeyframe {
  id: number;
  sequence_id: number;
  timestamp: number;
  parameter_values: any;
  created_at: Date;
}

export interface GeometryConfig {
  type: 'polygon' | 'fractal' | '3d-shape' | 'mandala' | 'tessellation';
  parameters: {
    vertices?: number;
    radius?: number;
    iterations?: number;
    complexity?: number;
    color?: string;
    opacity?: number;
    [key: string]: any;
  };
  transformations: {
    rotation: { x: number; y: number; z: number };
    scale: { x: number; y: number; z: number };
    translation: { x: number; y: number; z: number };
  };
}
