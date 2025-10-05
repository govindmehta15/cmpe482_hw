import pandas as pd
import matplotlib.pyplot as plt
import os

# Example: Load results from CSV, plot, save figures

def plot_metric_vs_param(csvfile, param_col, metric_col, figure_name, xlabel, ylabel):
    df = pd.read_csv(csvfile)
    plt.figure()
    for video in df['video'].unique():
        subset = df[df['video'] == video]
        plt.plot(subset[param_col], subset[metric_col], marker='o', label=video)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(f'results/plots/{figure_name}.png')
    plt.close()

# Example usage:
if __name__ == "__main__":
    os.makedirs("results/plots", exist_ok=True)
    # Quantization parameter experiment
    plot_metric_vs_param('results/qp_results.csv', 'QP', 'PSNR', 'psnr_vs_qp', 'QP', 'PSNR')
    plot_metric_vs_param('results/qp_results.csv', 'QP', 'SSIM', 'ssim_vs_qp', 'QP', 'SSIM')
    plot_metric_vs_param('results/qp_results.csv', 'QP', 'bitrate', 'bitrate_vs_qp', 'QP', 'Bitrate')

    # GOP experiment
    plot_metric_vs_param('results/gop_results.csv', 'GOP', 'PSNR', 'psnr_vs_gop', 'GOP Length', 'PSNR')
    plot_metric_vs_param('results/gop_results.csv', 'GOP', 'SSIM', 'ssim_vs_gop', 'GOP Length', 'SSIM')
    plot_metric_vs_param('results/gop_results.csv', 'GOP', 'bitrate', 'bitrate_vs_gop', 'GOP Length', 'Bitrate')

    # B-frames experiment
    plot_metric_vs_param('results/bframes_results.csv', 'B', 'PSNR', 'psnr_vs_bframes', 'B-frames', 'PSNR')
    plot_metric_vs_param('results/bframes_results.csv', 'B', 'SSIM', 'ssim_vs_bframes', 'B-frames', 'SSIM')
    plot_metric_vs_param('results/bframes_results.csv', 'B', 'bitrate', 'bitrate_vs_bframes', 'B-frames', 'Bitrate')

    # Codec comparison experiment
    plot_metric_vs_param('results/codec_results.csv', 'QP', 'PSNR', 'psnr_vs_qp_codec', 'QP', 'PSNR')
    plot_metric_vs_param('results/codec_results.csv', 'QP', 'SSIM', 'ssim_vs_qp_codec', 'QP', 'SSIM')
    plot_metric_vs_param('results/codec_results.csv', 'QP', 'bitrate', 'bitrate_vs_qp_codec', 'QP', 'Bitrate')