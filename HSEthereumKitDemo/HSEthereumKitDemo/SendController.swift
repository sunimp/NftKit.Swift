import UIKit
import HSEthereumKit
import RxSwift

class SendController: UIViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var addressTextField: UITextField?
    @IBOutlet weak var amountTextField: UITextField?
    @IBOutlet weak var sendCoin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Send"
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        view.endEditing(true)
    }

    @IBAction func send(_ sender: Any) {
        guard let address = addressTextField?.text, !address.isEmpty else {
            show(error: "Empty Address")
            return
        }

        guard let amountString = amountTextField?.text, let amount = Decimal(string: amountString) else {
            show(error: "Empty or Non Integer Amount")
            return
        }

        guard let ethereumKit = Manager.shared.ethereumKit else {
            return
        }

        let single: Single<EthereumTransaction>

        if (sender as? UIButton) == sendCoin {
            single = ethereumKit.sendErc20Single(to: address, contractAddress: Manager.contractAddress, amount: amount)
        } else {
            single = ethereumKit.sendSingle(to: address, amount: amount)
        }

        single
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] _ in
                    self?.showSuccess(address: address, amount: amount)
                }, onError: { [weak self] error in
                    self?.show(error: "Something conversion wrong: \(error)")
                })
                .disposed(by: disposeBag)
    }

    private func show(error: String) {
        let alert = UIAlertController(title: "Send Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }

    private func showSuccess(address: String, amount: Decimal) {
        addressTextField?.text = ""
        amountTextField?.text = ""

        let alert = UIAlertController(title: "Success", message: "\(amount.description) sent to \(address)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }

}
