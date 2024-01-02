import UIKit

class ViewController: UIViewController {
    
    let viewModel = SinglePokemonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showPokemonDataGenertic()
    }
}

