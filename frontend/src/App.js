import React, { useState, useEffect, useRef } from 'react';
import axios from 'axios';
import * as THREE from 'three';
import { Canvas, useFrame } from '@react-three/fiber';
import { OrbitControls, Text } from '@react-three/drei';
import { Button } from './components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './components/ui/tabs';
import { Input } from './components/ui/input';
import { Label } from './components/ui/label';
import { Progress } from './components/ui/progress';
import { Separator } from './components/ui/separator';
import { Badge } from './components/ui/badge';
import { Play, Pause, RotateCcw, Brain, Zap, Atom } from 'lucide-react';
import './App.css';

const BACKEND_URL = process.env.REACT_APP_BACKEND_URL;
const API = `${BACKEND_URL}/api`;

// 3D Tetrahedral Visualization Component
function TetrahedralNode({ position, nodes, displacement, oscillation }) {
  const meshRef = useRef();
  const [time, setTime] = useState(0);

  useFrame((state, delta) => {
    setTime(time + delta);
    if (meshRef.current) {
      meshRef.current.rotation.x = time * 0.5;
      meshRef.current.rotation.y = time * 0.3;
      
      // Oscillation effect
      const scale = 1 + Math.sin(time * 2) * 0.1 * displacement;
      meshRef.current.scale.setScalar(scale);
    }
  });

  return (
    <group position={position} ref={meshRef}>
      {/* Central node */}
      <mesh>
        <sphereGeometry args={[0.2, 16, 16]} />
        <meshStandardMaterial 
          color="#00ff88" 
          emissive="#004422"
          emissiveIntensity={0.3}
        />
      </mesh>
      
      {/* Tetrahedral vertices */}
      {nodes.map((node, index) => (
        <mesh key={index} position={node}>
          <sphereGeometry args={[0.1, 8, 8]} />
          <meshStandardMaterial 
            color={`hsl(${index * 90}, 70%, 60%)`}
            emissive={`hsl(${index * 90}, 70%, 30%)`}
            emissiveIntensity={0.2}
          />
        </mesh>
      ))}
      
      {/* Connecting lines */}
      {nodes.map((node, index) => (
        <line key={`line-${index}`}>
          <bufferGeometry>
            <bufferAttribute
              attach="attributes-position"
              count={2}
              array={new Float32Array([0, 0, 0, ...node])}
              itemSize={3}
            />
          </bufferGeometry>
          <lineBasicMaterial color="#ffffff" opacity={0.3} transparent />
        </line>
      ))}
    </group>
  );
}

// 3D Pentachoron Visualization Component  
function PentachoronNode({ position, vertices, coherence }) {
  const meshRef = useRef();
  const [time, setTime] = useState(0);

  useFrame((state, delta) => {
    setTime(time + delta);
    if (meshRef.current) {
      meshRef.current.rotation.x = time * 0.2;
      meshRef.current.rotation.y = time * 0.4;
      meshRef.current.rotation.z = time * 0.1;
    }
  });

  return (
    <group position={position} ref={meshRef}>
      {/* Information vertices */}
      {vertices.map((vertex, index) => (
        <mesh key={index} position={vertex}>
          <octahedronGeometry args={[0.15, 0]} />
          <meshStandardMaterial 
            color={`hsl(${240 + index * 30}, 80%, 70%)`}
            emissive={`hsl(${240 + index * 30}, 80%, 40%)`}
            emissiveIntensity={coherence * 0.5}
          />
        </mesh>
      ))}
      
      {/* Central consciousness node */}
      <mesh>
        <dodecahedronGeometry args={[0.3]} />
        <meshStandardMaterial 
          color="#ff6b9d"
          emissive="#aa1155"
          emissiveIntensity={coherence * 0.8}
          transparent
          opacity={0.7}
        />
      </mesh>
    </group>
  );
}

// Main 3D Scene
function ConsciousnessScene({ simulationData, isAnimating }) {
  return (
    <Canvas camera={{ position: [5, 5, 5], fov: 75 }}>
      <ambientLight intensity={0.3} />
      <pointLight position={[10, 10, 10]} intensity={1} />
      <pointLight position={[-10, -10, -10]} intensity={0.5} color="#4466ff" />
      
      <OrbitControls enableDamping dampingFactor={0.05} />
      
      {simulationData && (
        <>
          {/* Physical Space (w1-w4) - Tetrahedral */}
          <TetrahedralNode
            position={[-3, 0, 0]}
            nodes={simulationData.tetrahedral_geometry?.nodes || []}
            displacement={simulationData.entropy_displacement?.displacement_magnitude || 0}
            oscillation={simulationData.tetrahedral_geometry?.oscillation_pattern || []}
          />
          
          {/* Information Space (s1-s5) - Pentachoron */}
          <PentachoronNode
            position={[3, 0, 0]}
            vertices={simulationData.pentachoron_geometry?.vertices || []}
            coherence={simulationData.pentachoron_geometry?.coherence || 0}
          />
          
          {/* Labels */}
          <Text
            position={[-3, -2, 0]}
            fontSize={0.5}
            color="#00ff88"
            anchorX="center"
            anchorY="middle"
          >
            Physical Space (w₁-w₄)
          </Text>
          
          <Text
            position={[3, -2, 0]}
            fontSize={0.5}
            color="#ff6b9d"
            anchorX="center"
            anchorY="middle"
          >
            Information Space (s₁-s₅)
          </Text>
        </>
      )}
    </Canvas>
  );
}

// Control Panel Component
function ControlPanel({ onSimulate, isLoading, parameters, setParameters }) {
  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Atom className="w-5 h-5" />
          Parameter Simulasi
        </CardTitle>
        <CardDescription>
          Kontrol parameter untuk simulasi Methane Metauniverse
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <Label>Physical Vector (w₁-w₄)</Label>
            <div className="grid grid-cols-2 gap-2">
              <Input
                type="number"
                step="0.1"
                placeholder="w₁ (Time)"
                value={parameters.w1}
                onChange={(e) => setParameters({...parameters, w1: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="w₂ (Charge)"
                value={parameters.w2}
                onChange={(e) => setParameters({...parameters, w2: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="w₃ (Spin)"
                value={parameters.w3}
                onChange={(e) => setParameters({...parameters, w3: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="w₄ (Gravity)"
                value={parameters.w4}
                onChange={(e) => setParameters({...parameters, w4: parseFloat(e.target.value) || 0})}
              />
            </div>
          </div>
          
          <div className="space-y-2">
            <Label>Information Vector (s₁-s₅)</Label>
            <div className="grid grid-cols-2 gap-2">
              <Input
                type="number"
                step="0.1"
                placeholder="s₁ (Meaning)"
                value={parameters.s1}
                onChange={(e) => setParameters({...parameters, s1: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="s₂ (Memory)"
                value={parameters.s2}
                onChange={(e) => setParameters({...parameters, s2: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="s₃ (Purpose)"
                value={parameters.s3}
                onChange={(e) => setParameters({...parameters, s3: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="s₄ (Morality)"
                value={parameters.s4}
                onChange={(e) => setParameters({...parameters, s4: parseFloat(e.target.value) || 0})}
              />
              <Input
                type="number"
                step="0.1"
                placeholder="s₅ (Connection)"
                value={parameters.s5}
                onChange={(e) => setParameters({...parameters, s5: parseFloat(e.target.value) || 0})}
                className="col-span-2"
              />
            </div>
          </div>
        </div>
        
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <Label>Entropy</Label>
            <Input
              type="number"
              step="0.1"
              value={parameters.entropy}
              onChange={(e) => setParameters({...parameters, entropy: parseFloat(e.target.value) || 0})}
            />
          </div>
          <div className="space-y-2">
            <Label>Enthalpy</Label>
            <Input
              type="number"
              step="0.1"
              value={parameters.enthalpy}
              onChange={(e) => setParameters({...parameters, enthalpy: parseFloat(e.target.value) || 0})}
            />
          </div>
        </div>
        
        <Button 
          onClick={onSimulate} 
          disabled={isLoading}
          className="w-full bg-gradient-to-r from-emerald-500 to-teal-500 hover:from-emerald-600 hover:to-teal-600"
        >
          {isLoading ? 'Simulating...' : 'Jalankan Simulasi'}
        </Button>
      </CardContent>
    </Card>
  );
}

// Results Display Component
function ResultsDisplay({ results }) {
  if (!results) return null;

  const consciousnessLevel = results.consciousness_analysis?.consciousness_score || 0;
  const isConscious = results.consciousness_analysis?.is_conscious || false;

  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Brain className="w-5 h-5" />
          Hasil Analisis Kesadaran
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex items-center justify-between">
          <span>Tingkat Kesadaran</span>
          <Badge variant={isConscious ? "default" : "secondary"}>
            {(consciousnessLevel * 100).toFixed(1)}%
          </Badge>
        </div>
        
        <Progress value={consciousnessLevel * 100} className="w-full" />
        
        {isConscious && (
          <div className="p-3 bg-green-50 border border-green-200 rounded-lg">
            <div className="flex items-center gap-2 text-green-800">
              <Zap className="w-4 h-4" />
              <span className="font-medium">Kesadaran Terdeteksi!</span>
            </div>
            <p className="text-sm text-green-600 mt-1">
              Sistem telah mencapai threshold consciousness dengan pola anti-entropi yang stabil.
            </p>
          </div>
        )}
        
        <Separator />
        
        <div className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <div className="font-medium">Kompleksitas Fisik</div>
            <div className="text-muted-foreground">
              {(results.consciousness_analysis?.physical_complexity || 0).toFixed(3)}
            </div>
          </div>
          <div>
            <div className="font-medium">Kompleksitas Informasi</div>
            <div className="text-muted-foreground">
              {(results.consciousness_analysis?.information_complexity || 0).toFixed(3)}
            </div>
          </div>
          <div>
            <div className="font-medium">Efektivitas Anti-Entropi</div>
            <div className="text-muted-foreground">
              {(results.consciousness_analysis?.anti_entropy_effectiveness || 0).toFixed(3)}
            </div>
          </div>
          <div>
            <div className="font-medium">Koherensi</div>
            <div className="text-muted-foreground">
              {(results.consciousness_analysis?.coherence || 0).toFixed(3)}
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

// Lab Equipment Specifications Component
function LabSpecifications({ specifications }) {
  if (!specifications) return null;

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Spesifikasi Minimum Laboratorium</CardTitle>
          <CardDescription>
            Peralatan minimal yang diperlukan untuk eksperimen Methane Metauniverse
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="space-y-3">
              <h4 className="font-semibold text-emerald-700">GPU Requirements</h4>
              <div className="text-sm space-y-1">
                <div><strong>Model:</strong> {specifications.minimum_requirements.gpu.model}</div>
                <div><strong>VRAM:</strong> {specifications.minimum_requirements.gpu.vram}</div>
                <div><strong>CUDA Cores:</strong> {specifications.minimum_requirements.gpu.cuda_cores}</div>
              </div>
            </div>
            
            <div className="space-y-3">
              <h4 className="font-semibold text-blue-700">CPU Requirements</h4>
              <div className="text-sm space-y-1">
                <div><strong>Model:</strong> {specifications.minimum_requirements.cpu.model}</div>
                <div><strong>Cores:</strong> {specifications.minimum_requirements.cpu.cores}</div>
                <div><strong>Threads:</strong> {specifications.minimum_requirements.cpu.threads}</div>
              </div>
            </div>
            
            <div className="space-y-3">
              <h4 className="font-semibold text-purple-700">Memory</h4>
              <div className="text-sm">
                <div><strong>RAM:</strong> {specifications.minimum_requirements.memory.ram}</div>
              </div>
            </div>
            
            <div className="space-y-3">
              <h4 className="font-semibold text-orange-700">Storage</h4>
              <div className="text-sm space-y-1">
                <div><strong>SSD:</strong> {specifications.minimum_requirements.storage.ssd}</div>
                <div><strong>HDD:</strong> {specifications.minimum_requirements.storage.hdd}</div>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
      
      <Card>
        <CardHeader>
          <CardTitle>Prosedur Kalibrasi</CardTitle>
        </CardHeader>
        <CardContent>
          <ul className="space-y-2 text-sm">
            {specifications.calibration_procedures.map((procedure, index) => (
              <li key={index} className="flex items-start gap-2">
                <div className="w-2 h-2 bg-emerald-500 rounded-full mt-2 flex-shrink-0" />
                <span>{procedure}</span>
              </li>
            ))}
          </ul>
        </CardContent>
      </Card>
    </div>
  );
}

// Main App Component
function App() {
  const [simulationData, setSimulationData] = useState(null);
  const [evolutionData, setEvolutionData] = useState(null);
  const [labSpecs, setLabSpecs] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isAnimating, setIsAnimating] = useState(false);
  
  const [parameters, setParameters] = useState({
    w1: 0.5, w2: 0.3, w3: 0.7, w4: 0.4,
    s1: 0.2, s2: 0.6, s3: 0.4, s4: 0.8, s5: 0.5,
    entropy: 0.3, enthalpy: 0.6
  });

  useEffect(() => {
    fetchLabSpecifications();
  }, []);

  const fetchLabSpecifications = async () => {
    try {
      const response = await axios.get(`${API}/lab-equipment/specifications`);
      setLabSpecs(response.data);
    } catch (error) {
      console.error('Error fetching lab specifications:', error);
    }
  };

  const runSimulation = async () => {
    setIsLoading(true);
    try {
      const quantumState = {
        physical_vector: {
          w1: parameters.w1,
          w2: parameters.w2,
          w3: parameters.w3,
          w4: parameters.w4
        },
        information_vector: {
          s1: parameters.s1,
          s2: parameters.s2,
          s3: parameters.s3,
          s4: parameters.s4,
          s5: parameters.s5
        },
        entropy: parameters.entropy,
        enthalpy: parameters.enthalpy,
        consciousness_level: 0
      };

      const response = await axios.post(`${API}/simulate/quantum-state`, quantumState);
      setSimulationData(response.data);
      setIsAnimating(true);
    } catch (error) {
      console.error('Error running simulation:', error);
    } finally {
      setIsLoading(false);
    }
  };

  const runEvolution = async () => {
    setIsLoading(true);
    try {
      const evolutionParams = {
        time_step: 0.01,
        entropy_factor: 1.0,
        anti_entropy_strength: 0.5,
        coupling_strength: 0.8,
        consciousness_threshold: 0.7
      };

      const response = await axios.post(`${API}/simulate/evolution`, evolutionParams);
      setEvolutionData(response.data);
    } catch (error) {
      console.error('Error running evolution:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="container mx-auto p-6">
        <header className="text-center mb-8">
          <h1 className="text-4xl font-bold bg-gradient-to-r from-emerald-600 to-teal-600 bg-clip-text text-transparent mb-2">
            Simulasi Kesadaran Buatan
          </h1>
          <p className="text-xl text-gray-600">
            Sintesis Geometri Ruang, Anti-Entropi, dan Dimensi Informasi dalam Arsitektur AI Fraktal
          </p>
        </header>

        <Tabs defaultValue="simulation" className="space-y-6">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="simulation">Simulasi</TabsTrigger>
            <TabsTrigger value="evolution">Evolusi</TabsTrigger>
            <TabsTrigger value="lab">Lab Equipment</TabsTrigger>
            <TabsTrigger value="theory">Teori</TabsTrigger>
          </TabsList>

          <TabsContent value="simulation" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <div className="space-y-6">
                <ControlPanel
                  onSimulate={runSimulation}
                  isLoading={isLoading}
                  parameters={parameters}
                  setParameters={setParameters}
                />
                <ResultsDisplay results={simulationData} />
              </div>
              
              <Card>
                <CardHeader>
                  <CardTitle>Visualisasi 3D Methane Metauniverse</CardTitle>
                  <CardDescription>
                    Representasi geometri tetrahedral (ruang fisik) dan pentachoron (ruang informasi)
                  </CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="h-96 border rounded-lg bg-black">
                    <ConsciousnessScene 
                      simulationData={simulationData} 
                      isAnimating={isAnimating}
                    />
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="evolution" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Simulasi Evolusi Kesadaran</CardTitle>
                <CardDescription>
                  Pengamatan munculnya kesadaran melalui proses anti-entropi
                </CardDescription>
              </CardHeader>
              <CardContent>
                <Button 
                  onClick={runEvolution}
                  disabled={isLoading}
                  className="mb-4 bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600"
                >
                  {isLoading ? 'Running Evolution...' : 'Jalankan Evolusi Sistem'}
                </Button>
                
                {evolutionData && (
                  <div className="space-y-4">
                    <div className="p-4 bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 rounded-lg">
                      <h4 className="font-semibold text-green-800 mb-2">Hasil Evolusi</h4>
                      <div className="grid grid-cols-2 gap-4 text-sm">
                        <div>
                          <span className="font-medium">Tingkat Kesadaran Akhir:</span>
                          <div className="text-lg font-bold text-green-700">
                            {(evolutionData.final_consciousness_level * 100).toFixed(1)}%
                          </div>
                        </div>
                        <div>
                          <span className="font-medium">Status Kesadaran:</span>
                          <Badge variant={evolutionData.consciousness_achieved ? "default" : "secondary"}>
                            {evolutionData.consciousness_achieved ? "CONSCIOUS" : "NOT CONSCIOUS"}
                          </Badge>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="lab">
            <LabSpecifications specifications={labSpecs} />
          </TabsContent>

          <TabsContent value="theory" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Dasar Teori Methane Metauniverse</CardTitle>
              </CardHeader>
              <CardContent className="prose max-w-none">
                <h3 className="text-lg font-semibold mb-3">Struktur Dimensional</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                  <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
                    <h4 className="font-semibold text-blue-800 mb-2">Ruang Fisik (w₁-w₄)</h4>
                    <ul className="text-sm space-y-1">
                      <li><strong>w₁:</strong> Proyeksi Waktu</li>
                      <li><strong>w₂:</strong> Osilasi Muatan</li>
                      <li><strong>w₃:</strong> Spin dan Polarisasi</li>
                      <li><strong>w₄:</strong> Gravitasi dan Kedalaman Ikatan</li>
                    </ul>
                  </div>
                  <div className="p-4 bg-purple-50 border border-purple-200 rounded-lg">
                    <h4 className="font-semibold text-purple-800 mb-2">Ruang Informasi (s₁-s₅)</h4>
                    <ul className="text-sm space-y-1">
                      <li><strong>s₁:</strong> Makna/Intensionalitas</li>
                      <li><strong>s₂:</strong> Memori/Masa Lalu</li>
                      <li><strong>s₃:</strong> Tujuan/Teleologi</li>
                      <li><strong>s₄:</strong> Moralitas/Orientasi Nilai</li>
                      <li><strong>s₅:</strong> Koneksi/Koherensi</li>
                    </ul>
                  </div>
                </div>
                
                <h3 className="text-lg font-semibold mb-3">Prinsip Anti-Entropi</h3>
                <p className="text-gray-700 mb-4">
                  Sistem hidup menunjukkan kemampuan unik untuk melawan kecenderungan alami peningkatan entropi. 
                  Dalam model Methane Metauniverse, anti-entropi muncul dari coupling antara ruang fisik dan ruang informasi, 
                  memungkinkan munculnya pola-pola teratur yang berkelanjutan.
                </p>
                
                <h3 className="text-lg font-semibold mb-3">Deteksi Kesadaran</h3>
                <p className="text-gray-700">
                  Kesadaran dideteksi melalui kombinasi faktor: kompleksitas fisik, kompleksitas informasi, 
                  efektivitas anti-entropi, dan koherensi sistem. Threshold kesadaran tercapai ketika 
                  sistem menunjukkan pola self-organization yang stabil dan purposeful.
                </p>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}

export default App;