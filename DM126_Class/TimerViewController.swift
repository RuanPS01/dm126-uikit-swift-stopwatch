//
//  TimerViewController.swift
//  DM126_Class
//
//  Created by user270231 on 10/26/24.
//

import UIKit

class TimerViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var stackViewListLaps: UIStackView!
    @IBOutlet weak var playPauseOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    // MARK: - Propriedades
    private var timer: Timer?
    private var isRunning = false
    private var elapsedTime: Int = 0 // tempo em milissegundos
    private var lapTimes: [LapTime] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        configureStackView()
    }
            	
    // MARK: - Setup
    private func configureStackView() {
        stackViewListLaps.axis = .vertical
      stackViewListLaps.distribution = .fill // Mudado para fill ao invés de fillEqually
      stackViewListLaps.alignment = .top // Alinha ao topo
      stackViewListLaps.spacing = 8
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer() // Inicia o timer automaticamente ao entrar na tela
    }
    
    // MARK: - Setup
    private func setupInitialState() {
            stopOutlet.isEnabled = false
            updateTimerLabel()
            clearLapsDisplay()
        }
        
        // MARK: - Lap Times Display
    private func updateLapsDisplay() {
        clearLapsDisplay()
            
      // Pega as últimas 5 voltas
      let lastLaps = Array(lapTimes.suffix(5))
            
      // Itera em ordem reversa para adicionar do mais recente para o mais antigo
      for lap in lastLaps.reversed() {
          let lapNumber = lapTimes.firstIndex(where: { $0.timeInMiliseconds == lap.timeInMiliseconds }) ?? 0
        let lapLabel = createLapLabel(number: lapNumber + 1, time: lap.formattedTime())
        stackViewListLaps.addArrangedSubview(lapLabel)
      }
    }
        
        private func clearLapsDisplay() {
            stackViewListLaps.arrangedSubviews.forEach { view in
                stackViewListLaps.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
    private func createLapLabel(number: Int, time: String) -> UILabel {
        let label = UILabel()
      label.text = "Volta \(number): \(time)"
      label.textAlignment = .left
      label.font = UIFont.systemFont(ofSize: 16)
      label.textColor = .white
            
      // Configurações para garantir que a label se ajuste corretamente
      label.translatesAutoresizingMaskIntoConstraints = false
      label.heightAnchor.constraint(equalToConstant: 30).isActive = true // Altura fixa para cada label
            
      return label
    }
    
    // MARK: - Actions
    @IBAction func playPauseAction(_ sender: Any) {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
        updateButtonStates()
    }
    
    @IBAction func stopAction(_ sender: Any) {
        stopTimer()
        updateButtonStates()
    }
    
    // MARK: - Timer Logic
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.elapsedTime += 100 // Incrementa 100 milissegundos
            self?.updateTimerLabel()
        }
        playPauseOutlet.setTitle("Pause", for: .normal)
        stopOutlet.isEnabled = true
        updateButtonStates()
    }
    
    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        playPauseOutlet.setTitle("Play", for: .normal)
        
        // Salva o tempo atual no array e atualiza o display
        let lapTime = LapTime(timeInMiliseconds: elapsedTime, createdAt: Date())
        lapTimes.append(lapTime)
        updateLapsDisplay()
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
        setupInitialState()
    }
    
    // MARK: - UI Updates
    private func updateTimerLabel() {
        let minutes = (elapsedTime / 60000) % 60
        let seconds = (elapsedTime / 1000) % 60
        let milliseconds = (elapsedTime % 1000) / 100
        
        timerLabel.text = String(format: "%02d:%02d:%d", minutes, seconds, milliseconds)
    }
    
    private func updateButtonStates() {
        playPauseOutlet.setTitle(isRunning ? "Pause" : "Play", for: .normal)
        stopOutlet.isEnabled = isRunning || elapsedTime > 0
    }
    
    // MARK: - Helper Methods
    func getLapTimes() -> [LapTime] {
        return lapTimes
    }
}
