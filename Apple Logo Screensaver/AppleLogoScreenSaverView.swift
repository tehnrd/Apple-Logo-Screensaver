import ScreenSaver
import AVKit

class AppleLogoScreenSaverView: ScreenSaverView {
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        player = createAVPlayer()
        playerLayer = createAVPlayerLayer(player: player)
        player.play()
        self.layer = playerLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAVPlayer() -> AVPlayer {
        let appBundle: Bundle = Bundle(for: AppleLogoScreenSaverView.self)
        let url = appBundle.url(forResource: "video", withExtension: "mp4")
        let avPlayer = AVPlayer(url: url!)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        
        return avPlayer
    }
    
    func createAVPlayerLayer(player: AVPlayer) -> AVPlayerLayer {
        let avPlayerLayer: AVPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.videoGravity =  AVLayerVideoGravity.resizeAspectFill
        return avPlayerLayer
    }
    
    // Notification Handling
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        player.seek(to: CMTime.zero)
        player.play()
    }
    
    // Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
