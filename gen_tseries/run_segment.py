#!/usr/bin/env python3
import os


def _parse_args():
    """ Parse command line arguments """

    import argparse

    parser = argparse.ArgumentParser(
        description="Submit scripts to reshape model output",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    # Required: specify start year
    parser.add_argument(
        "--case",
        type=str,
        required=True,
        help="First year of run to convert to time series",
    )

    # Required: specify start year
    parser.add_argument(
        "--start_year",
        type=int,
        required=True,
        help="First year of run to convert to time series",
    )

    # Required: specify end year
    parser.add_argument(
        "--end_year",
        type=int,
        required=True,
        help="Last year of run to convert to time series",
    )

    # Optional: specify component(s) to run
    parser.add_argument(
        "--components",
        type=str,
        nargs="+",
        default=[
            "cam",
            "cice",
            "clm",
            "pop",
            "rtm",
        ],
        help="Components to convert to time series",
    )

    # Optional: location of DOUT_S_ROOT
    archive_default = os.path.join(
        os.sep, "glade", "scratch", os.environ["USER"], "archive"
    )
    parser.add_argument(
        "-a",
        "--archive_root",
        dest="archive_root",
        type=str,
        default=archive_default,
        help="base of DOUT_S_ROOT",
    )

    # Optional: specify which scripts to run
    parser.add_argument(
        "-s",
        "--scripts",
        dest="scripts",
        type=str,
        nargs="+",
        default=[
            "6hourly.sh",
            "monthly.sh",
            "daily.sh",
            "annual.sh",
        ],
        help="Scripts to submit to PBS",
    )

    # Optional: is this a dry-run? If so, don't submit anything
    parser.add_argument(
        "-d",
        "--dry-run",
        action="store_true",
        dest="dryrun",
        help="If true, do not actually submit job",
    )

    # Optional: By default, PBS will email users when jobs start and finish
    parser.add_argument(
        "--no-mail",
        action="store_false",
        dest="send_mail",
        help="If true, send PBS emails to {user}@ucar.edu",
    )

    return parser.parse_args()


###################

def launch_jobs(args):
    """
        Function that calls sbatch with correct options
    """
    mail_opt = (
        f"-m abe -M {os.environ['USER']}@ucar.edu"
        if args.send_mail
        else "-m n"
    )
    for component in args.components:
        for script in args.scripts:
            # Only CAM has 6-hour output
            if script == "6hourly.sh" and component != "cam":
                continue
            # Only POP has annual output
            if script == "annual.sh" and component != "pop":
                continue
            # Only POP has daily output
            if script == "daily.sh" and component != "pop" and component != "popeco":
                continue
            # Only run popeco for daily output
            if component == "popeco" and script != "daily.sh":
                continue
            job = f"{script.split('.')[0]}_{args.case}_{component}"
            logbase = f"logs/{job}"
            print(f"Submitting {script} for years {args.start_year} through {args.end_year} of {args.case} as {job}...")
            # TODO: figure out dependency option (probably need to capture jobid,
            #       store in a dict with key based on {job}, and then set up
            #       "-W depend=after:{jobid}"
            PBS_opts= f"{mail_opt} -N {job}" # --dependency=singleton"
            # PBS_opts += f" -o {logbase}.out.%J -e {logbase}.err.%J"
            script_vars = f"-v CASE={args.case},ARCHIVE_ROOT={args.archive_root},START_YEAR={args.start_year},END_YEAR={args.end_year},COMPONENT={component}"
            # run from logs/ so that PBS output ends up in correct place
            cmd = f"cd logs ; qsub {PBS_opts} {script_vars} ../{script}"
            if not args.dryrun:
                # note: the --dependency=singleton option means only one job per job name
                #       Some jobs had been crashing, and I think it was due to temporary
                #       files clobbering each other? But only having one year for each
                #       component / time period seemed to do the trick
                os.system(cmd)
            else:
                print(f"Command to run: {cmd}")

###################

if __name__ == "__main__":
    args = _parse_args()
    # Kind of kludgy method to ensure that both pop.h.nday1 and pop.h.ecosys.nday1
    # are converted to time series: add "popeco" component that daily.sh uses
    if "pop" in args.components and "daily.sh" in args.scripts:
        args.components.append("popeco")

    launch_jobs(args)
