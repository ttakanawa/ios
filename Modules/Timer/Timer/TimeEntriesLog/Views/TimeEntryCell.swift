import UIKit
import RxSwift

class TimeEntryCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var projectClientTaskLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!

    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
