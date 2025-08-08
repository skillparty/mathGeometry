-- Database schema for VJ Geometry Engine

-- Create presets table
CREATE TABLE IF NOT EXISTS presets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  config_json JSONB NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create animations table
CREATE TABLE IF NOT EXISTS animations (
  id SERIAL PRIMARY KEY,
  preset_id INTEGER REFERENCES presets(id) ON DELETE CASCADE,
  timeline_data JSONB NOT NULL,
  duration INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create fractal_configs table
CREATE TABLE IF NOT EXISTS fractal_configs (
  id SERIAL PRIMARY KEY,
  algorithm VARCHAR(100) NOT NULL,
  parameters JSONB NOT NULL,
  iterations INTEGER NOT NULL DEFAULT 50,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create recorded_sequences table
CREATE TABLE IF NOT EXISTS recorded_sequences (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  sequence_data JSONB NOT NULL,
  duration INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create sequence_keyframes table
CREATE TABLE IF NOT EXISTS sequence_keyframes (
  id SERIAL PRIMARY KEY,
  sequence_id INTEGER REFERENCES recorded_sequences(id) ON DELETE CASCADE,
  timestamp INTEGER NOT NULL,
  parameter_values JSONB NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_animations_preset_id ON animations(preset_id);
CREATE INDEX IF NOT EXISTS idx_sequence_keyframes_sequence_id ON sequence_keyframes(sequence_id);
CREATE INDEX IF NOT EXISTS idx_sequence_keyframes_timestamp ON sequence_keyframes(timestamp);
CREATE INDEX IF NOT EXISTS idx_presets_name ON presets(name);
CREATE INDEX IF NOT EXISTS idx_recorded_sequences_name ON recorded_sequences(name);

-- Add updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add triggers for updated_at columns
DROP TRIGGER IF EXISTS update_presets_updated_at ON presets;
CREATE TRIGGER update_presets_updated_at 
  BEFORE UPDATE ON presets 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_animations_updated_at ON animations;
CREATE TRIGGER update_animations_updated_at 
  BEFORE UPDATE ON animations 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_recorded_sequences_updated_at ON recorded_sequences;
CREATE TRIGGER update_recorded_sequences_updated_at 
  BEFORE UPDATE ON recorded_sequences 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
