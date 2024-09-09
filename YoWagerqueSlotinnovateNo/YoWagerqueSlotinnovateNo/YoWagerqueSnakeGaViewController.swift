//
//  YoWagerqueSnakeGaViewController.swift
//  YoWagerqueSlotinnovateNo
//
//  Created by adin on 2024/9/9.
//

import UIKit

class YoWagerqueSnakeGaViewController: UIViewController {

   
    @IBOutlet weak var gameAreaView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var snake: [UIView] = []
    var food: UIView!
    var direction: Direction = .right
    var timer: Timer?
    var isGameRunning = false
    
    let cellSize: CGFloat = 20
    let snakeColor = UIColor.green
    let foodColor = UIColor.red
    
    enum Direction {
        case up, down, left, right
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseButton.isEnabled = false
        setupGestureRecognizers()
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        resetGame()
        spawnSnake()
        spawnFood()

        // Allow some time before the first movement
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.startTimer()
        }
        
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        isGameRunning = true
    }

    @IBAction func pauseGame(_ sender: UIButton) {
        pauseTimer()
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        isGameRunning = false
    }
    
    func resetGame() {
        // Remove all snake and food views
        for segment in snake {
            segment.removeFromSuperview()
        }
        snake.removeAll()
        food?.removeFromSuperview()
        
        // Reset direction
        direction = .right
        isGameRunning = false
    }
    
    func spawnSnake() {
        let initialLength = 3
        let startX = (gameAreaView.frame.width / 2) - (CGFloat(initialLength) * cellSize / 2)
        let startY = (gameAreaView.frame.height / 2)
        
        for i in 0..<initialLength {
            let segment = createSegment(at: CGPoint(x: startX - CGFloat(i) * cellSize, y: startY))
            snake.append(segment)
            gameAreaView.addSubview(segment)
        }
    }
    
    func createSegment(at position: CGPoint) -> UIView {
        let segment = UIView(frame: CGRect(x: position.x, y: position.y, width: cellSize, height: cellSize))
        segment.backgroundColor = snakeColor
        return segment
    }
    
    func spawnFood() {
        let randomX = CGFloat(Int.random(in: 0..<Int(gameAreaView.frame.width / cellSize))) * cellSize
        let randomY = CGFloat(Int.random(in: 0..<Int(gameAreaView.frame.height / cellSize))) * cellSize
        food = UIView(frame: CGRect(x: randomX, y: randomY, width: cellSize, height: cellSize))
        food.backgroundColor = foodColor
        gameAreaView.addSubview(food)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateSnake), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    @objc func updateSnake() {
        guard isGameRunning else { return }
        
        var newHeadPosition = snake[0].frame.origin
        
        // Move based on current direction
        switch direction {
        case .up:
            newHeadPosition.y -= cellSize
        case .down:
            newHeadPosition.y += cellSize
        case .left:
            newHeadPosition.x -= cellSize
        case .right:
            newHeadPosition.x += cellSize
        }
        
        // Check for collisions with walls or self
        if checkCollision(newHeadPosition) {
            gameOver()
            return
        }

        // Move snake
        let newSegment = createSegment(at: newHeadPosition)
        snake.insert(newSegment, at: 0)
        gameAreaView.addSubview(newSegment)
        
        // Check if food is eaten
        if newSegment.frame.intersects(food.frame) {
            // Remove food and spawn new food
            food.removeFromSuperview()
            spawnFood()
        } else {
            let tail = snake.removeLast()
            tail.removeFromSuperview() // Remove tail if food is not eaten
        }
    }

    func checkCollision(_ position: CGPoint) -> Bool {
        // Check boundaries
        if position.x < 0 || position.y < 0 ||
           position.x + cellSize > gameAreaView.frame.width ||
           position.y + cellSize > gameAreaView.frame.height {
            return true
        }
        
        // Check self-collision
        for segment in snake.dropFirst() {
            if segment.frame.origin == position {
                return true
            }
        }
        
        return false
    }
    
    func gameOver() {
        guard isGameRunning else { return }
        
        pauseTimer()
        let alert = UIAlertController(title: "Game Over", message: "You lost! Try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame()
            self.startButton.isEnabled = true
            self.pauseButton.isEnabled = false
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setupGestureRecognizers() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection(_:)))
        swipeUp.direction = .up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection(_:)))
        swipeDown.direction = .down
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection(_:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection(_:)))
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    
    @objc func changeDirection(_ gesture: UISwipeGestureRecognizer) {
        guard isGameRunning else { return }
        
        switch gesture.direction {
        case .up:
            if direction != .down { direction = .up }
        case .down:
            if direction != .up { direction = .down }
        case .left:
            if direction != .right { direction = .left }
        case .right:
            if direction != .left { direction = .right }
        default:
            break
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
