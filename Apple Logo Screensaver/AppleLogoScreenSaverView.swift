import ScreenSaver
import AVKit

class AppleLogoScreenSaverView: ScreenSaverView {
    private var player: AVQueuePlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerLooper: AVPlayerLooper!
        
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        player = createAVQueuePlayer()
        playerLayer = createAVPlayerLayer(player: player)
        player.play()
        
        self.layer = playerLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAVQueuePlayer() -> AVQueuePlayer {
        let appBundle: Bundle = Bundle(for: AppleLogoScreenSaverView.self)
        let fileUrl = appBundle.url(forResource: "video", withExtension: "mp4")
        let asset = AVAsset(url: fileUrl!)
        let item = AVPlayerItem(asset: asset)
        
        player = AVQueuePlayer(items: [item])
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        return player
    }
    
    func createAVPlayerLayer(player: AVPlayer) -> AVPlayerLayer {
        let avPlayerLayer: AVPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.videoGravity =  AVLayerVideoGravity.resizeAspectFill
        
        return avPlayerLayer
    }
}
